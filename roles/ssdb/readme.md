#Description
ssdb模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: redis部署目录，{{ install_path }}/ssdb
* state: present或者absent
* port: ssdb port
* cache_size: ssdb cache内存大小，单位MB
* db_path: ssdb数据目录
* clusters: ssdb集群配置 
 

#Usage
```
roles:  
- { role: ssdb, install_path: /usr/local, port: 8888, db_path: /data, clusters: [{slave_id: 60, slave_ip: 172.28.5.60, slave_port: 8888, repl_type: mirror}, {slave_id: 59, slave_ip: 172.28.5.59, slave_port: 8888, repl_type: mirror}], cache_size: 500, state: present, tags: ssdb }
```
