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

* kubernetes_version: 1.11.2
* etcd_servers: 'http://192.168.1.1:2379'
* cluster_dns: 10.254.0.2
* cluster_domain: cluster.local
* k8s_tls_node_state: present
* docker_root_dir: "/var/lib/docker"
* kubernetes_cluster_name: test #使用master配置的name，用于获取相关证书
* kubernetes_cluster: new   #新节点部署使用new，重装使用exist。
* kubelet_root_dir: "/var/lib/kubelet"
* pause_image: "google_containers/pause-amd64.3.0:latest"

Usage
=============
```
roles:  
- { role: kubernetes_tls_node }
```
