#!/bin/sh

while getopts h:p: OPTION
do
	case $OPTION in
		h)	host=$OPTARG
			shift 2
			OPTIND=1
			;;
		p)	port=$OPTARG
			shift 2
			OPTIND=1
			;;
		*)	echo "usage: $0 -h hostname -p port"
			exit
			;;
	esac
done

if [ -z "$host" ]
then
	echo "no hostname"
     	exit
fi

if [ -z "$port" ]
then
        echo "no port"
        exit
fi

#-----------------init-----------------
YY=`date -d -1hour +%Y`
MM=`date -d -1hour +%m`
DD=`date -d -1hour +%d`
HH=`date -d now +%H`
backup_dir="{{ mysql_backup_path }}/$YY/$MM"
[ ! -d "$backup_dir" ] && mkdir -p $backup_dir
user="{{ backup_user }}"
passwd="{{ backup_password }}"
sql_file="$backup_dir/$host-$port-$YY-$MM-$DD.$HH.sql"
mysqldump="{{ mysql_path}}/bin/mysqldump"

#-----------------exit when sql exist-------
[ -f "$sql_file" ] && echo "file exist" >> $backup_dir/error.log && exit

#---------------start backup--------------------
echo "`date`	$host:$port backup start" >> $backup_dir/backup.log

databases=$({{ mysql_path }}/bin/mysql -u$user -h$host -P$port -p$passwd -e 'show databases\G' | awk  '/Database/ &&  $0 !~ /information_schema|mysql|performance_schema|test/ {ORS=" ";print $2}')

if [ -z "$databases" ]
then
	echo "`date`    $host:$port backup error:no databases find" >> $backup_dir/error.log
	exit
else
	echo "`date`    $host:$port backup databases:$databases" >> $backup_dir/backup.log
fi

$mysqldump -u$user -h$host -P$port -p$passwd --single-transaction --master-data=2 --net_buffer_length=8K --max_allowed_packet=16M --databases $databases > $sql_file
echo "`date`	$host:$port backup end" >> $backup_dir/backup.log
cd $backup_dir
tar cvzf "$host-$port-$YY-$MM-$DD.$HH.sql.tar.gz" $host-$port-$YY-$MM-$DD.$HH.sql
[ $? -eq 0 ] && rm -f $sql_file || echo "$sql_file backup error" | mail -s '$sql_file backup error' foo@examplie.com
