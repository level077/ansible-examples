#Description
sa-tools模块,一些常用的工具

#Args
* install_path: sa-tools部署目录,如/usr/local/sa-tools
* state: present或者absent

#Usage
```
roles:  
- { role: sa-tools, install_path: /usr/local/sa-tools, tags: sa-tools, state: present }
```
