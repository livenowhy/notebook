FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:py36
MAINTAINER livenowhy <livenowhy@hotmail.com>

RUN pip3 install Babel==2.3.4
RUN pip3 install chardet==3.0.4
RUN pip3 install decorator==4.0.10
RUN pip3 install docutils==0.12
RUN pip3 install ebaysdk==2.1.5
RUN pip3 install feedparser==5.2.1
RUN pip3 install gevent==1.1.2
RUN pip3 install greenlet==0.4.10
RUN pip3 install html2text==2016.9.19
RUN pip3 install Jinja2==2.10.1
RUN pip3 install libsass==0.12.3
RUN pip3 install lxml==3.7.1
RUN pip3 install Mako==1.0.4
RUN pip3 install MarkupSafe==0.23
RUN pip3 install mock==2.0.0
RUN pip3 install num2words==0.5.6
RUN pip3 install ofxparse==0.16
RUN pip3 install passlib==1.6.5
RUN pip3 install Pillow==5.4.1
RUN pip3 install polib==1.1.0
RUN pip3 install psutil==4.3.1
RUN pip3 install psycopg2==2.7.3.1
RUN pip3 install pydot==1.2.3
RUN pip3 install pyldap==2.4.28
RUN pip3 install pyparsing==2.1.10
RUN pip3 install PyPDF2==1.26.0
RUN pip3 install pyserial==3.1.1
RUN pip3 install python-dateutil==2.5.3
RUN pip3 install pytz==2016.7
RUN pip3 install pyusb==1.0.0
RUN pip3 install qrcode==5.3
RUN pip3 install reportlab==3.3.0
RUN pip3 install requests==2.20.0
RUN pip3 install zeep==3.1.0
RUN pip3 install vatnumber==1.2
RUN pip3 install vobject==0.9.3
RUN pip3 install Werkzeug==0.14.1
RUN pip3 install XlsxWriter==0.9.3
RUN pip3 install xlwt==1.3.*
RUN pip3 install xlrd==1.0.0

RUN yum install centos-release-scl rh-python36 -y
RUN yum install git wget nodejs-less bzip2-devel libjpeg-devel freetype-devel -y

# 注意: Odoo 12 要求安装 PostgreSQL 10 否则会出现报错
RUN yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
RUN yum install postgresql10 postgresql10-server -y

# 初始化 & 启动服务
#RUN /usr/pgsql-10/bin/postgresql-10-setup initdb && systemctl enable postgresql-10 && systemctl start postgresql-10

# 安装Wkhtmltopdf & 中文字体 & 安装Sass
# wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox-0.12.5-1.centos7.x86_64.rpm
COPY ./wkhtmltox.rpm /root/wkhtmltox.rpm
RUN yum localinstall /root/wkhtmltox.rpm -y && yum install wqy* sassc -y
# registry.cn-zhangjiakou.aliyuncs.com/livenowhy/centos:odoo