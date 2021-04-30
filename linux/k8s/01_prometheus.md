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
    $ nohup node_exporter &
    以上已经可以运行
    
    (配置 9100 端口可以直接被域名 corevm.livenowhy.com:9100 访问)
    

## Config

### Prometheus Alerting 

  Prometheus 中 alerting config 是用来定义 prometheus 和 alertmanager 通信方式的，在 prometheus.yml 配置。
    
    # 告警配置
    alerting:
      # 告警标签重写，参考 https://www.yuque.com/duduniao/linux/pkgsgv#ZoFlS
      alert_relabel_configs:
      [ - <relabel_config> ... ]
      
      # alertmanager 配置，用于配置和发现 alermanager 实例
      alertmanagers:
        - [ timeout: <duration> | default = 10s ]   # 向alertmanager发送告警的超时时间
          [ api_version: <string> | default = v1 ]  # 使用 alertmanager 的 API 版本
          [ path_prefix: <path> | default = / ]     # HTTP 报警路径前缀
          [ scheme: <scheme> | default = http ]     # 请求协议
        
          basic_auth: # 向请求添加Authorization header
            [ username: <string> ]
            [ password: <secret> ]
            [ password_file: <string> ]
          [ bearer_token: <string> ]
          [ bearer_token_file: <filename> ]
            
          tls_config:  # Configures the scrape request's TLS settings.
            [ <tls_config> ]
          
          [ proxy_url: <string> ] # Optional proxy URL.
    
          file_sd_configs: # 自动发现 alertmanager 的方式，与target的自动发现一致
            [ - <file_sd_config> ... ]
          kubernetes_sd_configs:
            [ - <kubernetes_sd_config> ... ]
          static_configs:
            [ - <static_config> ... ]
            
          relabel_configs: # 对发现的 alertmanager 进行筛选和标签重写，比如API中PATH
            [ - <relabel_config> ... ]

### Prometheus Alerting Rules

    groups:
      - name: <string>  # 组名，一个文件中唯一标识
        [ interval: <duration> | default = global.evaluation_interval ]
        rules:
          - alert: <string>    # 报警名称
            expr: <string>     # 报警规则表达式
      [ for: <duration> | default = 0s ]  # 当触发条件持续指定时间再发送告警, 发送前告警为 pending
      labels:         # 告警标签
        [ <labelname>: <tmpl_string> ]   # 会覆盖已有的标签, 用于后面 alertmanager 中筛选
        
      annotations:         # 告警注释
        [ <labelname>: <tmpl_string> ]   # 一般添加发送邮件的内容、标题等等。常用字段有:summary,description

## 告警状态 

  prometheus 的告警状态有三种，我们可以在 prometheus 的控制台页面上查看告警的状态

    inactive: 没有触发任何阈值，这个是根据 scrape_interval 参数(采集数据周期)和 evaluation_interval 参数(对比规则周期)去决定的
    pending: 已触发阈值但未满足告警持续时间,告警进入 pending 状态之后,需要等待规则配置的 for 时间,如果在这个时间内触发阈值的表达式一直成立,才会进入 firing 状态.
    firing: 已触发阈值且满足告警持续时间,将告警从 prometheus 发送给 alertmanager, 
            在 alertmanager 收到告警之后并不会立刻发送,还需要等待一个 group_wait 时间, 直到某个计算周期表达式为假, 告警状态变更为 inactive, 发送一个 resolve 给 altermanger, 说明此告警已解决

## Prometheus一条告警是怎么触发的

    1.采集数据 scrape_interval: 15s
    
    2.比对采集到的数据是否触发阈值 evaluation_interval: 15s
    
    3.判断是否超出持续时间(在这个时间内一直处于触发阈值状态)for: 5s
    
    4.告警到达 alertmanager 然后进行分组、抑制、静默
    
    5.通过分组、抑制、静默一系列机制的信息将会被发送，但是会延迟发送group_wait: 10s


## 参考文件

    https://github.com/prometheus/prometheus
    https://hub.docker.com/r/prom/prometheus/
    
    https://blog.csdn.net/liangcha007/article/details/88558389#1.1%20%E7%9B%B4%E6%8E%A5%E4%BD%BF%E7%94%A8metrics%E7%9A%84name%E8%BF%9B%E8%A1%8C%E6%9F%A5%E8%AF%A2
    https://www.cnblogs.com/think-in-java/p/9094635.html
    https://www.cnblogs.com/cjsblog/p/11585145.html
    
