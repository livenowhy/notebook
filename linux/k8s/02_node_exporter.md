# node_exporter
    
    监控服务器CPU、内存、磁盘、I/O等信息，首先需要安装 node_exporter。
    node_exporter 的作用是用于机器系统数据收集。
    
## 安装方法

    $ wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
    $ tar xvfz node_exporter-1.0.1.linux-amd64.tar.gz
    $ cd node_exporter-1.0.1.linux-amd64
    $ cp node_exporter /usr/bin/.
    $ node_exporter
    以上已经可以运行
    
    (配置 9100 端口可以直接被域名 node_exporter.livenowhy.com 访问)