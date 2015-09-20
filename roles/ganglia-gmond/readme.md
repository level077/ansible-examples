#Description
ganglia-gmond模块

#Args
* state: present或者absent
* cluster_name: 集群name
* mcast_ip: 组播IP

#Usage
```
roles:  
- { role: ganglia-gmond, cluster_name: db, mcast_ip: 239.2.11.71, tags: ganglia-gmond }
```
