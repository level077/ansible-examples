#Description
lvs模块

#Args
* package_path: 本例为/etc/ansible/packages 
* state: present或者absent
* keepalived_conf: keepalived.conf
* lvs_real_sh: lvs real server的配置脚本

#Usage
```
roles:  
- { role: lvs, keepalived_conf: keepalived.conf, lvs_real_sh: lvs_real.sh, state: present, tags: lvs}
```
