# docker 容器镜像构建

## 监控告警相关镜像

  `1` prometheus

    prometheus:2.22.0 基于 prometheus 2.22.0 版本的基础镜像
    registry.cn-zhangjiakou.aliyuncs.com/livenowhy/prometheus:2.22.0
    
    prometheus:lastest 基于 2.22.0 添加了相关配置之后的镜像
    registry.cn-zhangjiakou.aliyuncs.com/livenowhy/prometheus:lastest
    
  `2` alertmanager alertmanager v0.15.3 版本的基础镜像
  
    registry.cn-zhangjiakou.aliyuncs.com/livenowhy/alertmanager:lastest