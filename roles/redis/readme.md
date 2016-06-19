#Description
redis模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: redis部署目录，{{ install_path }}/redis
* state: present或者absent
* port: redis port
* cluster_enabled: 是否使用集群模式, "yes"或者"no"
* maxmemory: redis最大内存
* db_path: redis数据目录
* redis_version: 要部署redis的版本，为{{ package_path }}/redis/redis-{{ redis_version }}
* slaveof: slaveof.masterip, slaveof.masterport, 这个变量为可选
 

#Usage
```
roles:  
- { role: redis, install_path: /usr/local, db_path: /opt, port: 7000, cluster_enabled: "no", maxmemory: 1GB, redis_version: 3.0.2, slaveof: {masterip: 10.3.1.1, masterport: 6379}, state: present, tags: redis }
```
