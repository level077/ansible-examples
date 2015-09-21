#Description
memcache ganglia模块

#Args
* state: present或者absent
* port: 要监控的memcache port
* ansible_ssh_host: 要监控的memcache服务器IP

#Usage
```
roles:  
- { role: memcache_monitor, port: 11211, state: absent }
```
