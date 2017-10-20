#!/bin/sh
cd /root/ssl
KUBECTL={{ package_path }}/kubernetes/{{ version }}/kubectl
KUBE_APISERVER="https://{{ kube_apiserver }}:6443"
BOOTSTRAP_TOKEN=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')

cat > token.csv <<EOF
${BOOTSTRAP_TOKEN},kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF

$KUBECTL config set-cluster kubernetes --certificate-authority=/root/ssl/ca.pem --embed-certs=true --server=${KUBE_APISERVER} --kubeconfig=bootstrap.kubeconfig
$KUBECTL config set-credentials kubelet-bootstrap --token=${BOOTSTRAP_TOKEN} --kubeconfig=bootstrap.kubeconfig
$KUBECTL config set-context default --cluster=kubernetes --user=kubelet-bootstrap --kubeconfig=bootstrap.kubeconfig
$KUBECTL config use-context default --kubeconfig=bootstrap.kubeconfig

$KUBECTL config set-cluster kubernetes --certificate-authority=/root/ssl/ca.pem --embed-certs=true --server=${KUBE_APISERVER} --kubeconfig=kube-proxy.kubeconfig
$KUBECTL config set-credentials kube-proxy --client-certificate=/root/ssl/kube-proxy.pem --client-key=/root/ssl/kube-proxy-key.pem --embed-certs=true --kubeconfig=kube-proxy.kubeconfig
$KUBECTL config set-context default --cluster=kubernetes --user=kube-proxy --kubeconfig=kube-proxy.kubeconfig
$KUBECTL config use-context default --kubeconfig=kube-proxy.kubeconfig

$KUBECTL config set-cluster kubernetes --certificate-authority=/root/ssl/ca.pem --embed-certs=true --server=${KUBE_APISERVER} --kubeconfig=kubectl.kubeconfig
$KUBECTL config set-credentials admin --client-certificate=/root/ssl/admin.pem --embed-certs=true --client-key=/root/ssl/admin-key.pem --kubeconfig=kubectl.kubeconfig
$KUBECTL config set-context kubernetes --cluster=kubernetes --user=admin --kubeconfig=kubectl.kubeconfig
$KUBECTL config use-context kubernetes --kubeconfig=kubectl.kubeconfig
