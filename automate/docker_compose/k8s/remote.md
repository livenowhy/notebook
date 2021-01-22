# 远程存储

  Prometheus的本地存储设计可以减少其自身运维和管理的复杂度，同时能够满足大部分用户监控规模的需求。
  但是本地存储也意味着 Prometheus 无法持久化数据，无法存储大量历史数据，同时也无法灵活扩展和迁移。
  为了保持Prometheus的简单性，Prometheus并没有尝试在自身中解决以上问题，而是通过定义两个标准接口(remote_write/remote_read)，让用户可以基于这两个接口对接将数据保存到任意第三方的存储服务中，这种方式在Promthues中称为Remote Storage。
  
  
## Remote Write

  用户可以在Prometheus配置文件中指定Remote Write(远程写)的URL地址，一旦设置了该配置项，Prometheus将采集到的样本数据通过HTTP的形式发送给适配器(Adaptor)。
  而用户则可以在适配器中对接外部任意的服务。
  外部服务可以是真正的存储系统，公有云的存储服务，也可以是消息队列等任意形式。
  
  ![Remote Write](/share/notebook/automate/docker_compose/k8s/remote_write_path.png)
  

## Remote Read
  
  如下图所示，Promthues的Remote Read(远程读)也通过了一个适配器实现。
  在远程读的流程当中，当用户发起查询请求后，Promthues将向remote_read中配置的URL发起查询请求(matchers,ranges)，
  Adaptor根据请求条件从第三方存储服务中获取响应的数据。
  同时将数据转换为Promthues的原始样本数据返回给Prometheus Server。
  当获取到样本数据后，Promthues在本地使用PromQL对样本数据进行二次处理。
  
  注意：启用远程读设置后，只在数据查询时有效，对于规则文件的处理，以及Metadata API的处理都只基于Prometheus本地存储完成。
  
  ![Remote Read](/share/notebook/automate/docker_compose/k8s/remote_read_path.png)
  