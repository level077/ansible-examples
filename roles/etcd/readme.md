#Description
etcd模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: etcd部署目录，{{ install_path }}/etcd
* state: present或者absent
* version: 要部署etcd的版本，为{{ package_path }}/etcd/etcd-v{{ version }}-linux-amd64
* cluster_init: etcd集群信息
* cluster_token: 集群token
 

#Usage
```
roles:  
- { role: etcd, install_path: /usr/local, version: 2.3.0, cluster_init: "default=http://10.3.1.1:2380,default=http://10.3.1.2:2380,default=http://10.3.1.3:2380", cluster_token: test, state: present, tags: etcd }
```
