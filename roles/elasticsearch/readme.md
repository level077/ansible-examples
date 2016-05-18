#Description
elasticsearch模块

#Args
* package_path: 本例中为/etc/ansible/packages
* state: present或者absent
* version: 要同步的elasticsearch版本，文件为{{ package_path }}/elasticsearch/elasticsearch-{{ version }}
* state: present或者absent
* install_path: 安装目录
* JAVA_HOME: jdk目录
* cluster_name: es集群名字
* path_data: data目录
* path_log: log目录
* unicat_hosts: discovery host，可以写其中一台es服务器IP 

#Usage
```
roles:  
- { role: elasticsearch, version: 2.3.2, install_path: /usr/local, JAVA_HOME: /usr/local/elasticsearch, cluster_name: cc-log, path_data: /usr/local/elasticsearch/data, path_log: /usr/local/elasticsearch/logs, unicat_hosts: '"10.3.1.2"', ES_HEAP_SIZE: 4G, ES_HEAP_NEWSIZE: 875M, state: present }
```
