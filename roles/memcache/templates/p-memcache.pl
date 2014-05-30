#!/usr/bin/perl

#############################################################
# This is memcached collection script for Ganglia
# Author: Vladimir Vuksan http://vuksan.com/linux/
# Based off mymemcalc http://code.google.com/p/mymemcalc/
#
# You need to install XML::Simple and Cache::Memcached
# modules off CPAN ie.
# perl -MCPAN -e 'install XML::Simple'
# perl -MCPAN -e 'Cache::Memcached'
#
#############################################################
use strict;
use warnings FATAL => 'all';
use English qw ( -no_match_vars );
use XML::Simple;
use Cache::Memcached;
use Getopt::Long;

####################################################################################
# YOU MAY NEED TO MODIFY FOLLOWING
# Adjust this variables appropriately. Feel free to add any options to gmetric_command
# necessary for running gmetric in your environment to gmetric_options e.g. -c /etc/gmond.conf
####################################################################################
my $gmetric_exec = "/usr/bin/gmetric";
my $gmetric_options = " -d 120 ";
####################################################################################
my $gmetric_command = $gmetric_exec . $gmetric_options;
my $host = "127.0.0.1";
my $port = "11211";
my $opt_help;
my $old_time;
####################################################################################
# Where to store the last stats file
####################################################################################
my $tmp_dir_base="/tmp/memcached_stats";
my $tmp_stats_file=$tmp_dir_base . "/" . "memcached_stats";

# If the tmp directory doesn't exit create it
if ( ! -d $tmp_dir_base ) {
system("mkdir -p $tmp_dir_base");
}


GetOptions("help" => \$opt_help, #flag
           "h=s" => \$host,
           "p=s" => \$port
          );

if(defined($opt_help)){
print <<'END_USAGE'
Usage: ganglia_memcached.pl [OPTION]...
Collect memcached statistics

Options:
-help Usage information
-h Hostname of memcached. If not supplied defaults to 127.0.0.1
-p Port of memcached. If not supplied defaults to 11211
END_USAGE
  ;
  exit;
}

my $debug = 0;

# Set up the memcache pool
my @mp;

push(@mp, "$host:$port" );

my $mcache = new Cache::Memcached();
$mcache->set_servers(\@mp);

#use Data::Dumper;

# Get the stats
my %stats=();
my %old_stats;
%stats = %{$mcache->stats('misc')};

#print Dumper (%stats);


#################################################################################
# Decide if we need to use a metric suffix
#################################################################################
my $metric_suffix;
# If port metric is not 11211 append the port to metric name
if ( $port != "11211" ) {
$metric_suffix = "_" . $port;
} else {
$metric_suffix = "";
}

#################################################################################
# Memcache Hit Ratio
#################################################################################
my $hits = $stats{'total'}->{'get_hits'};
my $misses = $stats{'total'}->{'get_misses'};
my $hitsplusmisses = $hits + $misses;
my $hit_ratio;
if ( $hitsplusmisses == 0 ) {
$hit_ratio = 0.0;
} else {
$hit_ratio = $hits / $hitsplusmisses;
}

print 'memcache_hit_ratio: ' . substr( ( $hit_ratio * 100 ), 0, 5 ) . "%\n";

if ( $debug == 0 ) {
    system($gmetric_command . " -u ratio -tfloat -n memcache_hit_ratio".$metric_suffix." -v " . $hit_ratio);
}

#################################################################################
# Calculate Memcache Fill Ratio
#################################################################################
my $total_bytes = 0;
my $used_bytes = 0;
my $curr_connections = 0;
my $curr_items = 0;
my $fill_ratio = 0;
my $evictions = 0;
my $bytes_read = 0;
my $bytes_written = 0;
my $new_time = time;

foreach my $host ( keys %{ $stats{ 'hosts' } } ) {

  $total_bytes += $stats { 'hosts' }{ $host }{ 'misc' }->{ 'limit_maxbytes' };
  $used_bytes += $stats { 'hosts' }{ $host }{ 'misc' }->{ 'bytes' };
  $fill_ratio = $used_bytes / $total_bytes;
  $curr_connections = $stats { 'hosts' }{ $host }{ 'misc' }->{ 'curr_connections' };
  $curr_items = $stats { 'hosts' }{ $host }{ 'misc' }->{ 'curr_items' };
#
  $evictions = $stats { 'hosts' }{ $host }{ 'misc' }->{ 'evictions' };
  $bytes_read = $stats { 'hosts' }{ $host }{ 'misc' }->{ 'bytes_read' };
  $bytes_written = $stats { 'hosts' }{ $host }{ 'misc' }->{ 'bytes_written' };
}


if ( $debug == 0 ) {
    system($gmetric_command . " -u ratio -tfloat -n memcache_fill_ratio".$metric_suffix." -v " . $fill_ratio );
    system($gmetric_command . " -u connections -tfloat -n memcache_curr_connections".$metric_suffix." -v " . $curr_connections );
    system($gmetric_command . " -u items -tfloat -n memcache_curr_items".$metric_suffix." -v " . $curr_items );
}

print 'memcache_fill_ratio: ' . substr( ( ( $fill_ratio ) ) * 100, 0, 5 ) . "%\n";
print "memcache_items: " . $curr_items . "\n";
print "memcache_curr_conn: " . $curr_connections . "\n";

sub write_stats_file () {

open(NEWSTATUS, "> $tmp_stats_file");

print NEWSTATUS "evictions=" . $evictions . "\n";
print NEWSTATUS "bytes_read=" .$bytes_read . "\n";
print NEWSTATUS "bytes_written=" . $bytes_written . "\n";
 
close(NEWSTATUS);

}

###############################################################################
# Now I need to calculate counter metrics such as bytes in/out and evictions
# We need to store a baseline with statistics. If it's not there let's dump
# it into a file. Don't do anything else
###############################################################################
if ( ! -f $tmp_stats_file ) {
  print "Creating baseline. No output this cycle\n";
write_stats_file;
} else {

######################################################
  # Let's read in the file from the last poll
  open(OLDSTATUS, "< $tmp_stats_file");
 
  while(<OLDSTATUS>)
  {
if (/(.*)=(.*)/) {
  $old_stats{$1}=${2};
  }
  }
 
  # Get the time stamp when the stats file was last modified
  $old_time = (stat $tmp_stats_file)[9];
  close(OLDSTATUS);

if ( $debug == 0 ) {
# Make sure we are not getting negative numbers since they would indicate server was restarted
if ( $bytes_read >= $old_stats{'bytes_read'} ) {
my $time_diff = $new_time - $old_time;
system($gmetric_command . " -u number -tuint32 -n memcache_evictions".$metric_suffix." -v " . eval($evictions - $old_stats{'evictions'}) );
system($gmetric_command . " -u bytes/s -tfloat -n memcache_bytes_read".$metric_suffix." -v " . eval ( ($bytes_read - $old_stats{'bytes_read'}) / $time_diff) );
system($gmetric_command . " -u bytes/s -tfloat -n memcache_bytes_written".$metric_suffix." -v " . eval( ($bytes_written - $old_stats{'bytes_written'}) / $time_diff ) );
}
write_stats_file;

}

 
}


