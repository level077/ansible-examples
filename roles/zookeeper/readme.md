#Description
zookeeper模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: zookeeper部署目录，{{ install_path }}/zookeeper
* version: zookeeper版本
* state: present或者absent
* clusters: zookeeper集群配置
* dataDir: zookeeper数据目录
* dataLogDir: zookeeper日志目录
 

#Usage
```
roles:  
- { role: zookeeper, install_path: /usr/local, dataDir: /opt/zookeeper, dataLogDir: /opt/zookeeper, version: 3.4.6, clusters: [{host: im-zk-1, id: 2, ip: 127.0.0.1, port: 2181}, {host: test2, id: 1, ip: 10.3.1.141, port: 2181}], state: absent, tags: zookeeper }
```
