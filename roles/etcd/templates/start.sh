#!/bin/sh
nohup {{ install_path }}/etcd/etcd \
--listen-peer-urls http://{{ ansible_ssh_host }}:2380 \
--initial-advertise-peer-urls http://{{ ansible_ssh_host }}:2380 \
--listen-client-urls http://{{ ansible_ssh_host }}:2379 \
--advertise-client-urls http://{{ ansible_ssh_host }}:2379 \
--initial-cluster-token {{ cluster_token }} \
--initial-cluster {{ cluster_init }} \
--initial-cluster-state new \
--strict-reconfig-check &
