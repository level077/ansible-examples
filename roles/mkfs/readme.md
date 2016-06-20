#Description
mkfs模块，用户格式化硬盘，并且挂载

#Args
* fstype: 文件系统格式，xfs，ext4等
* state: present或者absent
* dev: 磁盘分区
* mount_dir: 挂载点
* force: yes or no

#Usage
```
roles:  
- { role: mkfs, fstype: xfs, dev: /dev/sdb, mount_dir: /datai, force: no }
```
