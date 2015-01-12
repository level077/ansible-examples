Description
====

ansible-examples 将平时常用的软件写成ansible roles。
* 新建了个package目录，用于存放文件。
* 每个role都提供了安装，升级，及卸载的功能，对应的参数是present,upgrade,absent.具体使用可以查看test.yml。如果打成rpm的包，就不用写的这么复杂了。
* 对于mongodb mysql tomcat这些都区分了端口。满足有单机多实例的需求。

Roles
============

common
------------
* 系统初始化，这里只是设置了ntpdate及安装epel源

ganglia-gmond
------------
* yum安装ganglia-gmond ganglia-python模块

ganglia-gmetad
------------
* yum安装ganglia-gmetad ganglia-web模块

jdk
------------
* 从package中rsync对应的jdk版本(需要事先在package/jdk/目录下存放相关文件)，且在同级目录下创建jdk软链
* 参数
  * jdk_file: jdk版本，对应package下目录名字，如package/jdk/jdk1.6.0_32
  * state: 安装模式，默认是present，还可以选择upgrade，absent

memcache
-----------
* 从package中rsync对应的memcache(需要事先在package/memcache/目录下存放相关文件)，这里是源码
* 源码安装，./configure && make && make install
* 参数
  * state: 安装模式，默认是present，还可以选择upgrade，absent
  * port: memcached listen端口，同时会创建该端口的启动脚本，如/etc/init.d/memcache_11211。启动脚本模板在templates下

mongodb
-----------
* 从package中rsync对应的mongodb(需要事先在package/mongodb/目录下存放相关文件)
* 参数
  * state: 安装模式，默认是present，还可以选择upgrade，absent
  * port: mongodb listen端口，同时会创建该端口的启动脚本，如/etc/init.d/mongodb_27017。启动脚本模板在templates下
  * db_path: mongodb db目录。默认值是/opt。根据port参数(假设27107)，最终会创建/opt/mongodb/27017目录，可以起多实例
  * install_path: 默认值/usr/local/app

mysql
----------
* 从package中rsync对应的mysql(需要事先在package/mysql/目录下存放相关文件)，这里的mysql是编译好的。无需再手动编译安装
* 参数
  * state: 安装模式，默认是present，还可以选择upgrade，absent
  * port: mysql listen端口，同时会创建该端口的启动脚本及配置文件，如/etc/init.d/mongodb_27017，/etc/mysql/3306/my.cnf。模板在templates下   
  * db_path: mysql db目录。默认值是/opt。根据port参数(假设3306)，最终会创建/opt/mysql/3306目录，可以起多实例
  * server_id: mysql server_id
  * install_path: 默认值/usr/local/app

nginx
----------
* 从package中rsync对应的mysql(需要事先在package/nginx/目录下存放相关文件)，源码
* 因为之前已经写了个install脚本，因此安装过程全在install脚本里
* 参数
  * state: 安装模式，默认是present，还可以选择upgrade，absent
  * install_path: 默认值/usr/local/app


redis
---------
* 从package中rsync对应的redis(需要事先在package/redis/目录下存放相关文件)
* 参数
  * state: 安装模式，默认是present，还可以选择upgrade，absent
  * install_path: 默认值/usr/local/app
  * db_path: redis db目录

tomcat
---------
* 从package中rsync对应的tomcat(需要事先在package/tomcat/目录下存放相关文件)
* 参数
  * state: 安装模式，默认是present，还可以选择upgrade，absent
  * install_path: 默认值/usr/local/tomcat
  * port: tomcat listen端口，根据port，install_path最终确立目录结构，设port=8310 install_path=/usr/local/tomcat，生成的目录为/usr/local/tomcat/tomcat_8310
  * shutdown_port: server.xml中的关闭监听端口
  * 还有很多参数，跟jvm设置有关，具体查看vars/main.yml

nrpe
---------
* yum安装nrpe
* 参数
  * state: 安装模式，默认是present，还可以选择upgrade，absent
  * allowed_hosts: nrpe配置项，nrpe.cfg模板中使用
* 模板 
  * nrpe.cfg: 根据ansible_facts添加磁盘监控，及设置allowed_hosts

Usage
==========
ansible-playbook -i hosts test.yml [-t tags] 
* -i: 指定host文件
* -t: 根据tags执行相应的role
