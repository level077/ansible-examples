etcdctl --endpoints "{{ etcd_servers }}" mkdir {{ flannel_etcd_prefix }}
etcdctl --endpoints "{{ etcd_servers }}" mk {{ flannel_etcd_prefix }}/config "{ \"Network\": \"{{ pod_ip_range }}\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"{{ flannel_network_type }}\" } }"
