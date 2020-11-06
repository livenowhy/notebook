FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/alpine:python_3_6

MAINTAINER livenowhy livenowhy@hotmail.com

RUN apk add --update
RUN apk add build-base
RUN apk add libffi-dev
RUN apk add openssl-dev
RUN apk add xmlsec
RUN apk add xmlsec-dev
RUN apk add openssl
RUN rm -rf /var/cache/apk/*

RUN pip install beautifulsoup4~=4.6.0
RUN pip install html5lib~=1.0.1
RUN pip install flask-login~=0.4.1
RUN pip install pytest~=3.6.2
RUN pip install xmlunittest~=0.5.0
RUN pip install freezegun~=0.3.11
RUN pip install pyOpenSSL==19.0.0
RUN pip install pytz==2018.9
RUN pip install defusedxml>=0.5.0
RUN pip install attrs>=18.1.0
RUN pip install signxml>=2.4.0
RUN pip install lxml>=3.8.0
RUN pip install iso8601~=0.1.12

RUN touch /usr/local/lib/python3.6/site-packages/my.pth
RUN mkdir /share && echo '/share' > /usr/local/lib/python3.6/site-packages/my.pth
