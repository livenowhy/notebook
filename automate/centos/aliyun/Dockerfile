FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:pip3
MAINTAINER livenowhy <livenowhy@hotmail.com>

COPY ./requirements.txt /home/
RUN cd /home/ && pip install -r requirements.txt && rm -rf /home/*

COPY ./aliyunsdk /home/aliyunsdk
RUN cp -r /home/aliyunsdk/aliyun-python-sdk-core/ /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-core && cd  /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-core && python3 setup.py install
RUN cp -r /home/aliyunsdk/aliyun-python-sdk-cms/ /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-cms && cd  /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-cms && python3 setup.py install
RUN cp -r /home/aliyunsdk/aliyun-python-sdk-vpc/ /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-vpc && cd  /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-vpc && python3 setup.py install
RUN cp -r /home/aliyunsdk/aliyun-python-sdk-ram/ /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-ram && cd  /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-ram && python3 setup.py install
RUN cp -r /home/aliyunsdk/aliyun-python-sdk-acm/ /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-acm && cd  /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-acm && python3 setup.py install
RUN cp -r /home/aliyunsdk/aliyun-python-sdk-sts/ /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-sts && cd  /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-sts && python3 setup.py install
RUN cp -r /home/aliyunsdk/aliyun-python-sdk-dyvmsapi/ /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-dyvmsapi && cd  /usr/local/lib64/python3.6/site-packages/aliyun-python-sdk-dyvmsapi && python3 setup.py install

#RUN cd /home/aliyunsdk/aliyun-python-sdk-core-v3/ && python3 setup.py install

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:aliyun