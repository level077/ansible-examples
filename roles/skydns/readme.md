#Description
skydns模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: skydns部署目录，{{ install_path }}/skydns
* state: present或者absent
* machines: etcd集群信息
* domain: 内部域名
 

#Usage
```
roles:  
- { role: skydns, install_path: /usr/local, machines: "http://10.3.1.1:2379,http://10.3.1.2:2379,http://10.3.1.3:2379", domain: "rcs.local.", state: present, tags: skydns }
```
