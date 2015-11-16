#Description
rocket模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: rocketmq部署目录，{{ install_path }}/rocketmq
* state: present或者absent
* brokerClusterName: rocketmq cluster name
* brokerName: broker name
* namesrvAddr: name server addresslist
* brokerPort: broker listen port
* storePathRootDir: rocketmq data store path
* storePathCommitLog: commitlog store path
* clusters: 集群配置
 

#Usage
```
roles:  
- { role: rocketmq, install_path: /usr/local, brokerClusterName: default, brokerName: test, namesrvAddr: '172.28.5.60:9876;172.28.5.59:9876', brokerPort: 10911, storePathRootDir: /data/rocketmq, storePathCommitLog: /data/rocketmq/commitlog, clusters: [{ip: 172.28.5.59, brokerId: 0, brokerRole: ASYNC_MASTER},{ip: 172.28.5.60, brokerId: 1, brokerRole: SLAVE}], tags: rocketmq, state: present }
```
