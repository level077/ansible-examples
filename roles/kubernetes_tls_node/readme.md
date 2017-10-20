Description
=============
k8s_tls_node模块

Args
=============
* version: kubernetes版本
* flannel_etcd_prefix: flannel需要的网络配置etcd路径 
* etcd_servers: etcd服务地址，包含端口
* cluster_dns: kube-dns service服务地址，service_ip_range中的IP
* cluster_domain: kubernetes集群内域名后缀

Usage
=============
```
roles:  
- { role: kubernetes_tls_node, version: 1.8.1, flannel_etcd_prefix: /kube-centos/network, etcd_servers: '192.168.1.1:2379', cluster_dns: 10.254.0.2, cluster_domain: cluster.local }
```

Note
============
* 必须部署完k8s_tls_master之后再部署node，因为运行中使用的证书文件都是在部署master过程中生成的。同时如果重新部署了master，也必须重新部署node，因为bootstarp使用到的token已被更新。
