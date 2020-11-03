# PushGateway
## 使用场景介绍及部署


    Prometheus 是一套开源的系统监控、报警、时间序列数据库的组合。
    Prometheus 基本原理是通过 Http 协议周期性抓取被监控组件的状态，而输出这些被监控的组件的 Http 接口为 Exporter。
    PushGateway 作为 Prometheus 生态中的一个重要一员，它允许任何客户端向其 Push 符合规范的自定义监控指标，在结合 Prometheus 统一收集监控。
    
    PushGateway 使用场景:
    Prometheus 采用定时 Pull 模式，可能由于子网络或者防火墙的原因，不能直接拉取各个 Target 的指标数据，此时可以采用各个 Target 往 PushGateway 上 Push 数据，然后 Prometheus 去 PushGateway 上定时 pull。
    其次在监控各个业务数据时，需要将各个不同的业务数据进行统一汇总，此时也可以采用 PushGateway 来统一收集，然后 Prometheus 来统一拉取。

## API 方式 Push 数据到 PushGateway

    要 Push 数据到 PushGateway 中，可以通过其提供的 API 标准接口来添加。
    默认 URL 地址为: http://<ip>:9091/metrics/job/<JOBNAME>{/<LABEL_NAME>/<LABEL_VALUE>}
    其中 <JOBNAME> 是必填项，为 job 标签值，后边可以跟任意数量的标签对，一般我们会添加一个 instance/<INSTANCE_NAME> 实例名称标签，来方便区分各个指标。
    
    接下来，可以 Push 一个简单的指标数据到 PushGateway 中测试一下。
    $ echo "test_metric 2323" | curl --data-binary @- http://pushgateway.livenowhy.com/metrics/job/test_job
    $ echo "test_metric 2323" | curl --data-binary @- http://pushgateway.livenowhy.com/metrics/job/test_job/instance/demo01
    
    执行完毕，刷新一下 PushGateway UI 页面，此时就能看到刚添加的 test_metric 指标数据了。
    
  ![指标数据](./images/push_gateway.jpg)
    
    除了 test_metric 外，同时还新增了 push_time_seconds 和 push_failure_time_seconds 两个指标，这两个是 PushGateway 系统自动生成的相关指标。
    此时，我们在 Prometheus UI 页面上 Graph 页面可以查询的到该指标了。

  ![Prometheus Graph](./images/prometheus_graph.jpg)
  
    这里要着重提一下的是:
    上图中 test_metric 我们查询出来的结果为:
    test_metric{appname="pushgateway",exported_instance="demo01",exported_job="test_job",instance="pushgateway.livenowhy.com:80",job="pushgateway"}。
    眼尖的会发现这里头好像不太对劲，刚刚提交的指标所属 job 名称为 test_job ，为啥显示的为 exported_job="test_job" ，而 job 显示为 job="pushgateway" ，这显然不太正确，那这是因为啥？
    其实是因为 Prometheus 配置中的一个参数 honor_labels (默认为 false)决定的，我们不妨再 Push 一个数据，来演示下添加 honor_labels: true 参数前后的变化。
    
    这次，我们 Push 一个复杂一些的，一次写入多个指标，而且每个指标添加 TYPE 及 HELP 说明。

    $ cat <<EOF | curl --data-binary @- http://pushgateway.livenowhy.com/metrics/job/test_job/instance/test_instance
    # TYPE test_metrics counter
    test_metrics{label="app1",name="demo"} 100.00
    # TYPE another_test_metrics gauge
    # HELP another_test_metrics Just an example.
    another_test_metrics 123.45
    EOF
    




## 使用 PushGateway 注意事项
   
    指标值只能是数字类型，非数字类型报错
    $ echo "test_metric 12ff" | curl --data-binary @- http://pushgateway.livenowhy.com/metrics/job/test_job_1
    text format parsing error in line 1: expected float as value, got "12ff"
    
    指标值支持最大长度为 16 位，超过16 位后默认置为 0
    $ echo "test_metric 1234567898765432123456789" | curl --data-binary @- pushgateway.livenowhy.com/metrics/job/test_job_2
    # 实际获取值 test_metric{job="test_job_2"}	1234567898765432200000000

## PushGateway 数据持久化操作

    默认 PushGateway 不做数据持久化操作，当 PushGateway 重启或者异常挂掉，导致数据的丢失，我们可以通过启动时添加 -persistence.file 和 -persistence.interval 参数来持久化数据。
    -persistence.file 表示本地持久化的文件，将 Push 的指标数据持久化保存到指定文件，-persistence.interval 表示本地持久化的指标数据保留时间，若设置为 5m，则表示 5 分钟后将删除存储的指标数据。
    
    $ docker run -d -p 9091:9091 prom/pushgateway "-persistence.file=pg_file –persistence.interval=5m"
    
## PushGateway 推送及 Prometheus 拉取时间设置
    
    Prometheus 每次从 PushGateway 拉取的数据，并不是拉取周期内用户推送上来的所有数据，而是最后一次 Push 到 PushGateway 上的数据，
    所以推荐设置推送时间小于或等于 Prometheus 拉取的时间，这样保证每次拉取的数据是最新 Push 上来的。




## 参考文档