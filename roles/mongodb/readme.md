#Description
mongodb模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: mongodb部署目录，{{ install_path }}/mongodb
* state: present或者absent
* port: mongodb port
* db_path: mongodb数据目录
* user: mongodb进程用户
 

#Usage
```
roles:  
- { role: mongodb, install_path: /usr/local, db_path: /data, port: 27017, user: nobody, state: present, tags: mongodb }
```
