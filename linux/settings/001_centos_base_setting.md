## centos 配置

#### 解决Centos7不能联网且ifconfig出现command not found
    
    $ ip addr  (ifconfig 不可用， 使用 ip addr 查看网卡分配)
    $ yum install net-tools (之后可以使用 ifconfig)

    1、激活网卡:
    $ vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
    
    将 ONBOOT=no 改为 ONBOOT=yes

    2、保存后重启网卡
    $ service network restart   此时就可以上网了

#### 免密码登陆

  `a` 生成秘钥

    $ ssh-keygen -t rsa -b 4096 -C "livenowhy@hotmail.com"
    $ ssh -T git@github.com    (TEST)

  `b` 配置 sshd

    $ vim /etc/ssh/sshd_config -->去掉下面三行的注释
    RSAAuthentication yes
    PubkeyAuthentication yes
    AuthorizedKeysFile      .ssh/authorized_keys

  `c` 添加文件

    $ chmod 600 authorized_keys
    $ service sshd restart   -->重启ssh服务

#### 安装pip

    $ https://bootstrap.pypa.io/get-pip.py -o /data/get-pip.py
    $ python /data/get-pip.py

#### supervisord 安装及设置

    $ pip2 install supervisor
    $ echo_supervisord_conf > /etc/supervisord.conf
    $ echo '[include]' >> /etc/supervisord.conf
    $ echo 'files = /etc/supervisord.d/*.ini' >> /etc/supervisord.conf
    $ mkdir /etc/supervisord.d/
    $ mkdir /var/log/supervisor/
    $ supervisord -c /etc/supervisord.conf

#### 安装 python3

    $ yum install epel-release -y   # 安装 EPEL 软件源
    $ yum install -y python36
    $ yum install -y python36-devel
    $ wget https://bootstrap.pypa.io/get-pip.py -o /data/get-pip.py
    $ python36 /data/get-pip.py

    yum install -y mysql-devel

#### 安装基础服务
    $ yum install -y gcc
    $ yum install -y rsync
    $ yum install -y python-simplejson

  `1` docker [docker 安装](docker_install.md)

  `3` mysql [mysql 安装](../db/mysql_install.md)

  `4` redis [redis 安装](../db/redis_install.md)

  `5` nginx [nginx 安装](nginx_install.md)


    
    
#### Centos安装桌面系统并设置成默认启动

  `1` 安装GNOME桌面环境
    
    $ yum -y groups install "GNOME Desktop"
    
  `2` 启动模式的默认选择：

    $ systemctl set-default multi-user.target   // 设置成命令模式
    $ systemctl set-default graphical.target    // 设置成图形模式
  
  `3` 完成安装后输入如下所示的命令:
  
    $ reboot
