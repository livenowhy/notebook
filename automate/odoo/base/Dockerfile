
FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:py36
MAINTAINER livenowhy <livenowhy@hotmail.com>
COPY ./requirements.txt /home/
RUN cd /home/ && pip3 install -r requirements.txt && rm -rf /home/*

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:odoo