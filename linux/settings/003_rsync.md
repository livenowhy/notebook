# rsync 服务器之间代码同步 

## 前期准备

    服务器端: corevm.livenowhy.com
    客户端：192.168.0.2

## 安装rsync

    $ yum install rsync
    
## 服务器端配置
    
    corevm.livenowhy.com 服务器端配置 rsyncd.conf 文件，yum 安装则是 vim /etc/rsyncd.conf
    
    log file=/var/log/rsync.log
    [share]
    path=/share
    use chroot=true
    max connections=4
    # 指定该模块是否可读写，即能否上传文件，false表示可读写，true表示可读不可写。所有模块默认不可上传
    read only = false
    
    # 指定该模式是否支持下载，设置为true表示客户端不能下载。所有模块默认可下载
    write only = false
    list=true
    uid=root
    gid=root
    hosts allow=*
    ignore errors
    auth users=root
    secrets file=/etc/rsyncd.passwd
    
    $ netstat -lntp | grep 'rsync'
    $ ps uax | grep 'rsync'
    $ rsync --daemon --config=/etc/rsyncd.conf


## 配置密码
  
  `1` 服务器端的

    vim /etc/rsyncd.passwd，无则服务器端新建，输入以下内容：
    $ root:J2h6sRwzy
    
  `2` 客户端
  
    $ vim /etc/rsyncd.passwd，无则服务器端新建，输入以下内容：
    $ J2h6sRwzy   (注意前面没有用户名)
    
    密码文件需要 600 权限，改变权限
    $ chmod 600 /etc/rsyncd.passwd

## 在服务器端，以daemon模式运行

    rsync --daemon
    
## 同步文件

    同步本地文件到服务器(客户端执行)
    rsync -av  --progress  doc/ root@corevm.livenowhy.com::share/   --password-file=/share/rsyncd.passwd
    rsync -av  --progress  . root@corevm.livenowhy.com::share/  --password-file=/share/rsyncd.passwd

    同步服务器到本地
    rsync -zvrtopg --progress -e 'ssh -p  6665' root@172.16.0.99:/media/sdb/user/root/bin .
    当第一次同步之后，后面再有新的文件添加时使用
    rsync -azvrtopg --progress -e 'ssh -p  6665' root@172.16.0.99:/media/sdb/user/root/bin .
     