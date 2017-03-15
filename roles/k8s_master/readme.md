Description  
====
k8s_master模块，带了kube-dns部署脚本kubedns-controller.yaml.sed， kubedns-svc.yaml.sed

Args  
====
* flannel_etcd_prefix: flannel需要的网络配置etcd路径 
* pod_ip_range: pod网段
* state: present或者absent
* etcd_server: etcd服务地址，包含端口
* service_ip_range: service网段 
* api_server: kube-apiserver服务地址，包换端口
* cluster_dns: kube-dns service服务地址，service_ip_range中的IP

Usage   
====
```
roles:  
- { role: k8s_master, flannel_etcd_prefix: /kube-centos/network, pod_ip_range: 172.30.0.0/16, etcd_server: "10.3.1.1:2379", service_ip_range: 10.254.0.0/16, api_server: "10.3.1.1:8080", cluster_dns: "10.254.0.10", state: present, tags: k8s_master}
```

Note   
====
* 执行完后并没有部署kube-dns，待k8s_node部署完后，再手动部署kube-dns
* 建议先在node上下载好kube-dns需要的镜像，或者在node的/etc/hosts中绑定61.91.161.217 gcr.io
* kube-dns部署文件在master的/usr/local/src下：kubedns-controller.yaml.sed，kubedns-svc.yaml.sed
