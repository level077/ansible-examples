#Description
openresty模块

#Args
* package_path: 本例中为/etc/ansible/packages
* state: present或者absent
* install_path: openresty部署目录
* conf: nginx.conf文件名，路径为{{ package_path }}/openresty/{{ conf }}
* version: openresty版本号，如1.9.7.4

#Usage
```
roles:  
- { role: openresty, install_path: /usr/local, version: 1.9.7.4, conf: nginx.conf, tags: nginx, state: absent }
```
