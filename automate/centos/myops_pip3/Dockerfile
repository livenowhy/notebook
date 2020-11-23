FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:py36
MAINTAINER livenowhy <livenowhy@hotmail.com>
RUN mkdir /root/.pip
COPY ./pip.conf /root/.pip/pip.conf

COPY ./requirements.txt /home/
RUN cd /home/ && pip install -r requirements.txt && rm -rf /home/*

#Twisted==18.9.0
#dlib==19.21.0
#eight==1.0.0
#face-recognition==1.3.0
#face-recognition-models==0.3.0
#freezegun==0.3.11
#future==0.18.2
#isodate==0.6.0
#jmespath==0.9.4
#Markdown==3.1.1
#numpy==1.16.6
#pycryptodome==3.9.4
#pypng==0.0.20
#repoze.lru==0.7
#signxml==2.8.0
#xmlsec==1.3.8
#zope.interface==4.6.0
# pip freeze

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:myops_pip3