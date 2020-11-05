# prometheus 部署

## node_exporter
    
    监控服务器CPU、内存、磁盘、I/O等信息，首先需要安装 node_exporter。
    node_exporter 的作用是用于机器系统数据收集。
    
### node_exporter 安装方法

    $ wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
    $ tar xvfz node_exporter-1.0.1.linux-amd64.tar.gz
    $ cd node_exporter-1.0.1.linux-amd64
    $ cp node_exporter /usr/bin/.
    $ node_exporter
    以上已经可以运行
    
    (配置 9100 端口可以直接被域名 node_exporter.livenowhy.com 访问)
    
## 参考文件

    https://github.com/prometheus/prometheus
    https://hub.docker.com/r/prom/prometheus/
    
    https://blog.csdn.net/liangcha007/article/details/88558389#1.1%20%E7%9B%B4%E6%8E%A5%E4%BD%BF%E7%94%A8metrics%E7%9A%84name%E8%BF%9B%E8%A1%8C%E6%9F%A5%E8%AF%A2
    https://www.cnblogs.com/think-in-java/p/9094635.html
    