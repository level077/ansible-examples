#Description
memcache模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: redis部署目录，{{ install_path }}/redis
* state: present或者absent
* port: memcache port
* memory_size: memcached内存大小

#Usage
```
roles:  
- { role: memcache, port: 11211, memory_size: 40m, state: present, tags: memcache }
```
