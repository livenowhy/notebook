FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:pip3
MAINTAINER livenowhy <livenowhy@hotmail.com>

COPY ./requirements.txt /home/
RUN cd /home/ && pip install -r requirements.txt && rm -rf /home/*

COPY ./aliyunsdk /home/aliyunsdk

RUN cp -r /home/aliyunsdk/aliyun-python-sdk-acm/ /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-acm && cd  /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-acm && python3 setup.py install

#RUN cd /home/aliyunsdk/aliyun-python-sdk-core-v3/ && python3 setup.py install

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:aliyun

acm-sdk-python==0.4.11
aliyun-python-sdk-core-v3==2.13.3
aliyun-python-sdk-tag==1.0.1
aliyunsdkcore==1.0.3