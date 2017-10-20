#!/bin/sh
cd /root/ssl
./cfssl_linux-amd64 gencert -initca ca-csr.json | ./cfssljson_linux-amd64 -bare ca
./cfssl_linux-amd64 gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubernetes-csr.json | ./cfssljson_linux-amd64 -bare kubernetes
./cfssl_linux-amd64 gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | ./cfssljson_linux-amd64 -bare admin
./cfssl_linux-amd64 gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes  kube-proxy-csr.json | ./cfssljson_linux-amd64 -bare kube-proxy
