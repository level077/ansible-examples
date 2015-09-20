#Description
jdk模块

#Args
* package_path: 本例中为/etc/ansible/packages
* state: present或者absent
* jdk_file: 要同步的jdk文件名，在{{ package_path }}/jdk/{{ jdk_file }}
* state: present或者absent

#Usage
```
roles:  
- { role: jdk, jdk_file: jdk1.7.0_15, tags: jdk }
```
