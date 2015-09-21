#Description
redis ganglia监控模块

#Args
* state: present或者absent
* port: 要监听的redis port
* redis_cli: redis_cli命令路径
* ansible_ssh_host: 要监听的redis服务器IP
 

#Usage
```
roles:  
- { role: redis_monitor, port: 7000, redis_cli: /usr/local/redis/bin/redis-cli, state: absent, tags: redis_monitor }
```
