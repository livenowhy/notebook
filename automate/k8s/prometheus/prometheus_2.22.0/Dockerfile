FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:7.6
MAINTAINER livenowhy <livenowhy@hotmail.com>

# prometheus 版本
ARG BIN_VERSION="2.22.0"

COPY prometheus-${BIN_VERSION}.linux-amd64/prometheus                  /bin/prometheus
COPY prometheus-${BIN_VERSION}.linux-amd64/promtool                    /bin/promtool
COPY prometheus-${BIN_VERSION}.linux-amd64/console_libraries/          /usr/share/prometheus/console_libraries/
COPY prometheus-${BIN_VERSION}.linux-amd64/consoles/                   /usr/share/prometheus/consoles/

# 实际运行中可能需要替换的 prometheus 配置
COPY prometheus-${BIN_VERSION}.linux-amd64/prometheus.yml  /etc/prometheus/prometheus.yml

RUN ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/
RUN mkdir -p /prometheus

EXPOSE     9090
VOLUME     ["/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.enable-lifecycle", \
             "--web.console.templates=/usr/share/prometheus/consoles" ]

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/prometheus:2.22.0
# docker run -d -p 9090:9090 --name prometheus  registry.cn-zhangjiakou.aliyuncs.com/livenowhy/prometheus:2.22.0