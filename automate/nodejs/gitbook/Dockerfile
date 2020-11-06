FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/node:base_alpine
MAINTAINER livenowhy <livenowhy@hotmail.com>

ARG VERSION=3.2.0
LABEL version=$VERSION
RUN cnpm install --global gitbook-cli
RUN gitbook fetch ${VERSION}
EXPOSE 4000 35729

RUN mkdir /share
#RUN cd /share/notebook && gitbook install
#CMD /usr/local/bin/gitbook serve


# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/node:gitbook