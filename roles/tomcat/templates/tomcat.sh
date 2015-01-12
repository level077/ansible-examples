#!/bin/sh

if [ -n "$1" ]
then
	port="$1"
else
	echo  "no port"
	exit 255
fi	

if [ -n "$2" ]
then
	cmd="$2"
else
	echo "no cmd"
	exit 255	
fi


if [ `echo $port | grep '[a-zA-Z]'` ]
then
	echo "port error:$port"
	exit 253
fi

tomcat_dir=$(ps axu  | grep "${port}/" | grep  'java' | awk  '{for(i=1;i<=NF;i++) {if($i ~ /Dcatalina.base=/) print $i}}' | awk  -F  '=' '{print $2}')

if [ -z "$tomcat_dir" ]
then
	tomcat_dir={{ install_path }}/tomcat/tomcat_$port
fi

pid=$(ps axu  | grep "${port}/" | grep  'java' | awk '{print $2}')

stop()
{
	echo "kill -9 $pid"
	kill -9 $pid
	echo "rm -rf $tomcat_dir/work/Catalina/*"
	rm -rf $tomcat_dir/work/Catalina/*
	echo "find $tomcat_dir/webapps/*   -maxdepth 0 -type d  ! -name "ROOT"|xargs rm -rf"
	find $tomcat_dir/webapps/*   -maxdepth 0 -type d  ! -name "ROOT"|xargs rm -rf
}

start()
{
	export JAVA_HOME="/usr/local/jdk"
	export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
	echo "/bin/sh $tomcat_dir/bin/startup.sh"
	/bin/sh $tomcat_dir/bin/startup.sh
}

tailog()
{
	YY=$(date -d now +%Y)
	MM=$(date -d now +%m)
	DD=$(date -d now +%d)	
	log_file="$tomcat_dir/logs/catalina.out.$YY-$MM-$DD.out"
	tail -200 $log_file
}

case "$cmd" in
	stop)
		stop
		;;
	start)
		start
		;;
	restart)
		stop
		start
		;;
	offline)
		echo "echo offline > $tomcat_dir/webapps/ROOT/1.htm"
		echo offline > $tomcat_dir/webapps/ROOT/1.htm
		;;
	online)
		echo "echo ok > $tomcat_dir/webapps/ROOT/1.htm"
		echo ok > $tomcat_dir/webapps/ROOT/1.htm
		;;
	tailog)
		tailog
		;;
	*)
		echo "cmd args error"
		exit 252
		;;
esac
