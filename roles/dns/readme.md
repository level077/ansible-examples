#Description
dns模块

#Args
* state: present或者absent
* nameserver: nameserver list
 

#Usage
```
roles:  
- { role: dns, nameserver: ["10.3.1.5","10.3.1.6"], state: present, tags: dns }
```
