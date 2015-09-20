#Description
mysql模块

#Args
* package_path: 本例中为/etc/ansible/packages
* state: present或者absent
* install_path: mysql部署目录
* mysql_file: mysql文件目录，存放路径为{{ package_path }}/mysql/{{ mysql_file }}
* port: mysql监听端口
* db_path: mysql db数据目录
* innodb_buffer_pool_size: buffer pool内存大小
* server_id: server id

#Usage
```
roles:  
- { role: mysql, mysql_file: mysql_5.6.12, innodb_buffer_pool_size: 1G, port: 3306, db_path: /opt, server_id: 58, install_path: /usr/local, tags: mysql, state: present }
- { role: mysql, mysql_file: mysql_5.6.12, innodb_buffer_pool_size: 1G, port: 3307, db_path: /opt, server_id: 59, install_path: /usr/local, tags: mysql, state: present }
```
