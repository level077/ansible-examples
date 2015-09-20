#Description
ganglia-gmetad模块

#Args
* package_path: 本例中为/etc/ansible/packages
* state: present或者absent

#Usage
```
roles:  
- { role: ganglia-gmond, package_path: /etc/ansible/packages, state: present, tags: ganglia-gmetad }
```
