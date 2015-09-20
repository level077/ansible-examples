#Description
openresty模块

#Args
* package_path: 本例中为/etc/ansible/packages
* state: present或者absent
* install_path: openresty部署目录
* conf: nginx.conf文件名，路径为{{ package_path }}/openresty/{{ conf }}

#Usage
```
roles:  
- { role: openresty, install_path: /usr/local, conf: nginx.conf, tags: nginx, state: absent }
```
