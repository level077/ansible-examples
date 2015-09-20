#Description
mysql监控模块,包含一个nrpe配置，一个ganglia监控脚本

#Args
* state: present或者absent
* port: 要监听的mysql port
* ansible_ssh_host: 要监听的mysql服务器IP
* monitor_user: mysql中用于监听的用户名
* monitor_password: mysql中用于监听的用户密码
* install_path: mysql执行文件的路径，如{{ install_path }}/mysql/bin/mysql
 

#Usage
```
roles:  
- { role: mysql_monitor, port: 33061, install_path: /usr/local, monitor_user: monitor, monitor_password: monitor, tags: mysql_monitor, state: absent }
```
