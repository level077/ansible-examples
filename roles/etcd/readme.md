#Description
etcd模块

#Args
* etcd_cluster: etcd static cluster配置
* etcd_token: etcd token
* etcd_data_dir: etcd data dir
* etcd_state: new or exist
* state: absent or present

#Usage
```
roles:
- { role: etcd, etcd_cluster: "infra1=http://10.1.1.30:2380,infra2=http://10.1.1.28:2380,infra3=http://10.1.1.27:2380", etcd_token: test, etcd_state: new, etcd_data_dir: /data, state: present, tags: etcd }
```
