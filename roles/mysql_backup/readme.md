#Description
mysql备份模块，包含物理备份和逻辑备份两个脚本

#Args
* package_path: 本例中为/etc/ansible/packages
* state: present或者absent
* install_path: mysql部署目录
* mysql_backup_path: 备份目录
* backup_user: 备份用户名
* backup_password: 备份密码

#Usage
```
roles:  
- { role: mysql_backup, mysql_path: /usr/local/mysql, mysql_backup_path: /opt/mysql_backup, backup_user: backup, backup_password: xxxx, tags: mysql_backup, state: present }
```
