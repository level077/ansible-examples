#Description
flamegraph模块.on_cpu.sh及off_cpu.sh是用于生产火焰图的脚本

#Args
* install_path: flamegraph部署目录,如/usr/local/flamegraph
* kernel: `uname -r`的返回值,用于选择安装对应的kernel debuginfo.因为下载的包会很大,所以事先下载好对应的rpm包放入package_path中.

#Usage
```
roles:  
- { role: flamegraph, install_path: /usr/local, kernel: 2.6.32-573.el6.x86_64, tags: flamegraph}
```
