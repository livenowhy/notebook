FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:tools
MAINTAINER livenowhy <livenowhy@hotmail.com>
RUN yum install python-devel -y
COPY ./get-pip.py /home/
RUN python /home/get-pip.py && rm -rf /home/*

# 设置包路径
RUN touch /usr/lib/python2.7/site-packages/my.pth && mkdir /data && echo '/data' > /usr/lib/python2.7/site-packages/my.pth

COPY ./requirements.txt /home/
RUN pip install -r /home/requirements.txt && rm -rf /home/*
RUN pip install requests -i https://pypi.mirrors.ustc.edu.cn/simple/

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:pip2

