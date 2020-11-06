FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/mysql:8.0.base

MAINTAINER livenowhy livenowhy@hotmail.com

WORKDIR /tmp

ADD default.sql r.sql
#ADD mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh 
