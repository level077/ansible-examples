Description
====
k8s_node模块，部署完后可进行kube-dns部署，具体可参考k8s_master说明

Args
====
* flannel_etcd_prefix: flannel需要的网络配置etcd路径 
* etcd_server: etcd服务地址，包含端口
* state: present或者absent
* api_server: kube-apiserver服务地址，包换端口
* cluster_dns: kube-dns service服务地址，service_ip_range中的IP

Usage
====
```
roles:  
- { role: k8s_node, flannel_etcd_prefix: /kube-centos/network, etcd_server: "10.3.1.1:2379", api_server: "10.3.1.1:8080", cluster_dns: "10.254.0.10", state: present, tags: k8s_node}
```
