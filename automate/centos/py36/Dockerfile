FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:tools
MAINTAINER livenowhy <livenowhy@hotmail.com>

# (可能需要提前执行yum -y groupinstall "Development tools")
RUN yum install python36 python36-devel python3-devel libxml* uwsgi-plugin-python36 -y

COPY ./get-pip.py /home/
RUN python3.6 /home/get-pip.py && rm -rf /home/* && ln -sv /usr/lib64/uwsgi/python36_plugin.so /usr/lib64/uwsgi/python_plugin.so

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:py36