Description
====
* 新建了个package目录，用于存放文件。
* 每个role都提供了安装，升级，及卸载的功能，对应的参数是present,upgrade,absent。
* 这些roles仅适用于centos6
* 在group_vars中定义了全局变量: package_path和state
* ansible_ssh_host变量定义在hosts文件中
