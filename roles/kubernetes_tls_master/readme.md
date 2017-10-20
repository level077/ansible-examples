Description
===========
kubernetes_tls_master模块，带了kube-dns部署脚本kubedns-cm.yaml， kubedns-sa.yaml，kubedns-controller.yaml.sed，kubedns-svc.yaml.sed。该模块是自行创建需要的key，且开启RBAC。另外一个k8s_master是纯yum部署，版本更新不及时。

Pre-install
===========
* 下载cfssl，并放入ansible自定义的分发目录，如：/etc/ansible/packages/kubernetes
* 下载对应的kubernetes.tar.gz(https://dl.k8s.io/v1.8.1/kubernetes.tar.gz)，解压后将相关应用(kubectl，kube-apiserver，kube-controller-manager，kube-scheduler，kubelet，kube-proxy)放入ansible目录：/etc/ansible/packages/kubernetes/1.8.1/

Args
=============
* kubernetes_hosts: kube-apiserver部署的机器IP，或者其他域名，用户https的域名验证
* kube_apiserver: kube-apiserver的IP
* version: kubenetes版本
* flannel_etcd_prefix: flannel需要的网络配置etcd路径 
* flannel_network_type: flannel网络类型，可以是vxlan，host-gw等
* pod_ip_range: pod网段
* state: present或者absent
* etcd_servers: etcd服务地址，包含端口
* service_ip_range: service网段 
* cluster_dns: kube-dns service服务地址，service_ip_range中的IP
* cluster_domain: kubernetes集群内的域名后缀

Usage
===========
```
roles:  
- { role: kubernetes_tls_master, kubernetes_hosts: ['192.168.1.1'], kube_apiserver: 192.168.1.1, version: 1.8.1, flannel_etcd_prefix: /kube-centos/network, pod_ip_range: 172.30.0.0/16, flannel_network_type: vxlan, etcd_servers: '192.168.1.1:2379', service_ip_range: 10.254.0.0/16, cluster_dns: 10.254.0.2, cluster_domain: cluster.local }
```

Post-install
===========
* 待部node署完后，先执行kubectl get csr;kubectl certificate approve xxx，以便让node加入集群，才可进去后续的应用部署
* 如果gcr.io被墙，可在node的/etc/hosts中绑定61.91.161.217 gcr.io
* kube-dns部署文件在master的/usr/local/src下：kubedns-controller.yaml.sed，kubedns-svc.yaml.sed，kubedns-cm.yaml，kubedns-sa.yaml
