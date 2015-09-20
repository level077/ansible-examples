#Description
tomcat模块

#Args
* package_path: 本例中为/etc/ansible/packages
* state: present或者absent
* install_path: tomcat部署目录
* port: tomcat监听端口
* shutdown_port: tomcat关闭端口
* tomcat_file: tomcat目录名, 文件存放在{{ package_path }}/tomcat/{{ tomcat_file }}
* Xmn: jvm年轻代内存大小
* Xms: jvm内存最小值
* Xmx: jvm内存最大值
* PermSize: jvm永久代内存大小
* MaxPerSize: jvm永久代内存最大值
* context: webapp相关配置
* war_path: 存放war包的目录
* 

#Usage
```
roles:  
- { role: tomcat, tomcat_file: tomcat7, install_path: /usr/local, port: 8100, shutdown_port: 18100, Xmn: 875m, Xms: 3072m, Xmx: 3072m, PermSize: 128m, MaxPermSize: 128m, context: [{"webapp":"foo.war","path":"/foo"}], war_path: /usr/local/apps, tags: tomcat }
```
