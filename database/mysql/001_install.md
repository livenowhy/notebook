# CentOS 下的 Mysql 的安装和使用

## 安装 mysql

    $ yum update -y
    $ yum -y install mysql mysql-server mysql-devel mariadb-server

## 启动设置

    添加到开机启动
    $ systemctl enable mariadb.service

    启动服务
    $ systemctl start mariadb.service
    $ systemctl stop mariadb.service
    $ systemctl restart mariadb.service

    $ mysql -u root -p

## mysql 设置

    $ vi /etc/my.cnf.d/server.cnf
    $ vi /etc/my.cnf.d/client.cnf
    $ vi /etc/my.cnf.d/mysql-clients.cnf

## 数据库登陆

    以下方法:
    $ mysql -u root -p
    $ mysql -h localhost -u root -p123
    $ mysql -uroot -prddroot -h db.livenowhy.com -P 3306 -D registry

    CREATE DATABASE ***

    $ mysql -uroot -pxxx -h 127.0.0.1 -P 3306
    如果使用 localhost 会出现:
    ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock'

## 允许root用户在任何地方进行远程登录，并具有所有库任何操作权限，具体操作如下：

    在本机先使用root用户登录mysql：
    mysql -u root -p
    进行授权操作:
    mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION;
    重载授权表:
    FLUSH PRIVILEGES;
    退出mysql数据库:
    exit

    并且注释下面文件中 bind-address = 127.0.0.1
    vi /etc/mysql/my.cnf
    ubuntu 重启 mysql: /etc/init.d/mysql restart

## 重置密码

  `1` 重置密码的第一步就是跳过 mysql 的密码认证过程, 方法如下:

    # vim /etc/my.cnf (windows下修改的是my.ini)
    在文档内搜索 mysqld 定位到 [mysqld] 文本段:
    在 [mysqld] 后面任意一行添加 "skip-grant-tables" 用来跳过密码验证的过程:
    [mysqld]
    datadir=/var/lib/mysql
    skip-grant-tables
    # 保存文档并退出

  `2` 重启MySQL

    # systemctl restart mariadb.service

  `3` 重启之后输入 mysql 即可进入 mysql

    mysql> use mysql;
    mysql> update user set password=password("你的新密码") where user="root";
    mysql> flush privileges;
    mysql> quit
    到这里root账户就已经重置成新的密码了

  `4` 编辑 my.cnf, 去掉刚才添加的内容, 然后重启 mysql