FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:py36
MAINTAINER livenowhy <livenowhy@hotmail.com>
RUN mkdir /root/.pip
COPY ./pip.conf /root/.pip/pip.conf

COPY ./requirements.txt /home/
RUN cd /home/ && pip install -r requirements.txt && rm -rf /home/*

#Twisted==18.9.0
# pip freeze

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:myops_pip3