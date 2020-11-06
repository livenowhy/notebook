FROM docker.io/centos:centos7.6.1810
MAINTAINER livenowhy <livenowhy@hotmail.com>
RUN yes | cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum update -y && yum upgrade -y
RUN rm -rf /home/*

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:7.6