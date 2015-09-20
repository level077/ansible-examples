#Description
user用于创建用户，并添加相应的key，同时选择是否添加到sudo中  

#Args
* package_path: 存放ssh_pubkey的目录，本例中为/etc/ansible/packages
* state: present创建用户，absent删除用户
* username: 用户名
* ssh_pubkey: pubkey文件名，具体路径为{{ package_path }}/user/{{ ssh_pubkey }}
* is_sudo: yes或者no

#Usage
roles:  
- { role: user, username: xiaoming, ssh_pubkey: xiaoming.pub, is_sudo: "yes", tags: user }
