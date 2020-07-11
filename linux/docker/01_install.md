# docker 安装

## centos install

    $ yum update -y
    $ yum upgrade -y
    $ yum install -y yum-utils
    
    (download.docker.com 慢 可以使用 mirrors.aliyun.com)
    # $ yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    $ yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    $ yum install -y docker-ce docker-ce-cli containerd.io
    $ systemctl start docker
    $ systemctl enable docker.service
    
    $ pip3 install docker-compose
    
## 配置镜像代理

    $ mkdir -p /etc/docker
    
    $ tee /etc/docker/daemon.json <<-'EOF'
    {
        "registry-mirrors": ["https://5y127n6j.mirror.aliyuncs.com"]
    }
    EOF
    

## docker 容器中设置中文语言包的问题

  `1` 查看系统语言包

    $ locale -a  (会发现没有中文包)
    C
    POSIX
    en_US.utf8

  `2` 解决方案

    $ yum install kde-l10n-Chinese -y 安装语言包(针对centos 7)
    $ yum update
    $ yum upgrade
    
    # 更新gitbc 包(因为该镜像已阉割了该包的部分功能，所以需要更新需要先 update)
    $ yum reinstall glibc-common -y 
    
    $ localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 (设置系统语言包)
    $ LC_ALL=zh_CN.UTF-8

    可以采用直接修改/etc/locale.conf 文件来实现,不过需要reboot)
    
  `3` 采用Dockerfile 的方式
 
    RUN yum install kde-l10n-Chinese -y
    RUN yum install glibc-common -y
    RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
    ENV LC_ALL zh_CN.UTF-8


## 登陆阿里运仓库

    $ docker login --username=hi35608059@aliyun.com registry.cn-zhangjiakou.aliyuncs.com

    $ docker login --username=hi35608059@aliyun.com registry.cn-hangzhou.aliyuncs.com