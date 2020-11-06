FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:7.6
MAINTAINER livenowhy <livenowhy@hotmail.com>

RUN yum install gcc redis net-tools psmisc mysql-devel rsync python-devel openldap-devel libevent-devel libxslt-devel libxml2-devel epel-release -y
# 安装 EPEL 软件源 epel-release

# docker 支持中文
RUN yum install kde-l10n-Chinese -y && yum update -y && yum upgrade -y && yum reinstall glibc-common -y && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LC_ALL zh_CN.UTF-8
RUN yum update -y

# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:tools