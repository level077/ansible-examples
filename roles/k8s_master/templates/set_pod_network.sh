etcdctl mkdir {{ flannel_etcd_prefix }}
etcdctl mk {{ flannel_etcd_prefix }}/config "{ \"Network\": \"{{ pod_ip_range }}\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }"
