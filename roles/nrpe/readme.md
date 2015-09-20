#Description
nagaios nrpe模块，添加了一个check_sas，用于磁盘检测，并添加到crontab中

#Args
* state: present或者absent
* ansible_hostname: 主机名
* allowed_hosts: 允许访问nrpe的机器，一般为nagios服务器的IP
* nsca_host: nsca服务器IP

#Usage
```
roles:  
- { role: nrpe, allowed_hosts: 10.3.1.0/24, nsca_host: 10.3.1.151, tags: nrpe }
```
