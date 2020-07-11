# 安装部署 odoo

## 创建 odoo 用户并授权

  在 ubuntu 上安装 odoo 时，需要注意一点不可以在 root 用户下安装 odoo

  `1` 创建新用户

    $ sudo adduser odoo
    然后编辑 /etc/sudoers 为 odoo 授权,修改文件如下:
    # User privilege specification
    root ALL=(ALL:ALL)ALL
    odoo ALL=(ALL:ALL)ALL
    最后保存退出，这样 odoo 用户就拥有了 root 权限
    $ su odoo 切换到 odoo 用户部署 odoo

## 更新依赖包

    $ sudo apt-get update
    $ sudo apt-get upgrade
    $ sudo apt-get install git -y

    $ sudo apt-get install libreadline-dev -y
    $ sudo apt-get install zlib1g -y
    $ sudo apt-get install zlib1g.dev -y

    $ sudo apt-get install libpq-dev libldap2-dev libsasl2-dev libxslt1-dev -y
    $ sudo apt-get install python3-setuptools python3-wheel -y

## 安装 Node.js

    $ sudo apt-get install -y npm
    $ sudo ln -s /usr/bin/nodejs /usr/bin/node
    $ sudo npm install -g less
    $ sudo apt-get install gcc make libpng-dev -y


## 安装中文字体和报表打印需要的 wkhtmltopdf

    $ sudo apt-get install ttf-wqy-zenhei -y
    $ sudo apt-get install ttf-wqy-microhei -y

    $ sudo apt-get install libtool -y
    $ sudo apt-get install nasm -y
    $ sudo apt-get install libxrender1 -y
    $ sudo apt-get install xfonts-utils -y
    $ sudo apt-get install xfonts-base -y
    $ sudo apt-get install xfonts-utils -y
    $ sudo apt-get install xfonts-75dpi -y
    $ sudo apt-get install libfontenc1 -y
    $ sudo apt-get install fontconfig -y
    $ sudo apt-get install xfonts-encodings -y
    $ sudo apt-get install libjpeg-turbo8
    $ sudo apt-get install xvfb -y
    $ sudo apt-get install x11-common -y

    $ wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
    $ sudo dpkg -i wkhtmltox_0.12.5-1.xenial_amd64.deb
    $ sudo apt-get install -f

    前两步是安装中文字体，第三步是下载 wkhtmltopdf，第四步是安装wkhtmltopdf。在执行第四步的时候很可能会提示缺少依赖包，根据提示的信息使用命令sudo apt-get-f install进行安装即可

## 安装 python3 依赖的pip3

    $ sudo apt-get install -y python3-pip


## 源码安装 odoo

    $ git clone https://github.com/odoo/odoo.git odoo11 -b 11.0 --depth=1
    (如果安装其他版本，比如odoo12 直接修改 -b 后的数值参数即可)

## 安装 odoo 依赖包
    $ sudo pip3 install Babel decorator docutils ebaysdk feedparser gevent greenlet html2text Jinja2 lxml Mako MarkupSafe mock num2words ofxparse passlib Pillow psutil psycogreen psycopg2 pydot pyparsing PyPDF2 pyserial python-dateutil python-openid pytz pyusb PyYAML qrcode reportlab requests six suds-jurko vatnumber vobject Werkzeug XlsxWriter xlwt xlrd


## 安装 PostgreSQL

    注意: Odoo 12 要求安装 PostgreSQL 10 否则会出现报错

    centos:
    $ yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
    $ yum install postgresql10 postgresql10-server -y

    ubuntu:
    Create /etc/apt/sources.list.d/pgdg.list
    add:
    deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main


    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update

    $ sudo apt-get install postgresql-10

    # 初始化 & 启动服务
    $ sudo systemctl enable postgresql && sudo systemctl start postgresql

    进入 postgres 命令窗口并创建数据库用户 odoo:

    $ sudo su - postgres
    >createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo
    >Enter password for new role: *****
    >Enter it again:*****
    >exit

## 启动 odoo 服务

    $ ./odoo-bin (默认情况下，Odoo实例使用的是 8069 端口)

