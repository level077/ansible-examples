#Description
supervisord模块

#Args
* state: present或者absent
* service: supervisord管理的服务
* command: 该service的启动命令
* env: 该service的环境变量
 
#Usage
```
roles:  
- { role: supervisor, service: openfire, command: /bin/sh /usr/local/mrs/bin/openfire.sh, env: 'JAVA_HOME="/usr/local/jdk",OPENFIRE_OPTS="-Xmn875m -Xms3072m -Xmx3072m -XX:PermSize=128m -XX:MaxPermSize=128m -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:MaxTenuringThreshold=16 -XX:+ExplicitGCInvokesConcurrent -XX:+CMSParallelRemarkEnabled -XX:+PrintTenuringDistribution -XX:+PrintGCDateStamps -XX:StringTableSize=10000"', tags: supervisor, state: absent }
```
