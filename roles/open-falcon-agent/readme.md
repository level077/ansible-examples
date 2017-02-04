#Description
open-falcon-agent模块

#Args
* package_path: 本例为/etc/ansible/packages 
* install_path: open-falcon-agent部署目录，{{ install_path }}/open-falcon-agent
* state: present或者absent
* version: 版本
* hbs_addr: hbs地址
* transfer_addr: transfer地址，数组格式，可以写多个
 

#Usage
```
roles:  
- { role: open-falcon-agent, install_path: /usr/local/open-falcon, version: 5.1.0, hbs_addr: "10.3.101.54:6030", transfer_addr: ["10.3.101.54:8433"], state: present }
```
