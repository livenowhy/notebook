FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/prometheus:2.22.0
MAINTAINER livenowhy <livenowhy@hotmail.com>

# 实际运行中可能需要替换的 prometheus 配置
COPY prometheus.yml   /etc/prometheus/prometheus.yml
COPY rules.yml        /etc/prometheus/rules.yml

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/prometheus:lastest
# docker run -d -p 9090:9090 --name prometheus  registry.cn-zhangjiakou.aliyuncs.com/livenowhy/prometheus:lastest