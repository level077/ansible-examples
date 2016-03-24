#Description
server_info模块

#Args
* idc: idc name
* elastic_host: elasticsearch host
* elastic_port: elasticsearch port
 

#Usage
```
roles:  
- { role: server_info, idc: test, elastic_host: 127.0.0.1, elastic_port: 9200, state: present, tags: server_info }
```
