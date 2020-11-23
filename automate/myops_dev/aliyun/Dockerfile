FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:myops_pip3
MAINTAINER livenowhy <livenowhy@hotmail.com>

COPY ./requirements.txt /home/
RUN cd /home/ && pip install -r requirements.txt && rm -rf /home/*


# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:ali
# aliyunsdkcore==1.0.3