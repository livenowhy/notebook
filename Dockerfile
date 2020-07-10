FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/node:gitbook
MAINTAINER livenowhy <livenowhy@hotmail.com>

RUN mkdir /share/notebook
WORKDIR /share/notebook
ADD . /share/notebook
RUN cd /share/notebook && gitbook install
CMD /usr/local/bin/gitbook serve

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/node:notebook