#Description
kafka模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: kafka部署目录，{{ install_path }}/kafka
* version: kafka版本
* state: present或者absent
* clusters: kafka集群配置
* zk_clusters: zookeeper集群地址
* log_path: kafka日志目录
 

#Usage
```
roles:  
- { role: kafka, install_path: /usr/local, version: 2.10-0.8.2.1, log_path: /data, clusters: [{id: 61, ip:  172.28.5.61,  port: 9092}, {id: 60, ip: 172.28.5.60, port: 9092}, {id: 59, ip: 172.28.5.59, port: 58}], zk_clusters: "172.28.5.61:2181,172.28.5.60:2181,172.28.5.59:2181", state: present, tags: kafka }
```
