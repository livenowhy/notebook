# Git 服务器搭建

  `1` 安装Git
     
    $ yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-devel
    $ yum install git
    
  创建一个git用户组和用户,用来运行git服务:
  
    $ groupadd git
    $ adduser git -g git
    
  `2` 创建证书登录
  收集所有需要登录的用户的公钥，公钥位于id_rsa.pub文件中，
  把公钥导入到/home/git/.ssh/authorized_keys文件里,一行一个。如果没有该文件创建它:
  
    $ cd /home/git/
    $ mkdir .ssh
    $ chmod 700 .ssh
    $ touch .ssh/authorized_keys
    $ chmod 600 .ssh/authorized_keys
   
  `3` 初始化Git仓库
  首先我们选定一个目录作为Git仓库，假定是/home/gitrepo/test.git，在/home/gitrepo目录下输入命令:
    
    $ cd /home
    $ mkdir gitrepo
    $ chown git:git gitrepo/
    $ cd gitrepo
    $ git init --bare test.git
    Initialized empty Git repository in /home/gitrepo/test.git/
    
    以上命令Git创建一个空仓库，服务器上的Git仓库通常都以.git结尾。然后，把仓库所属用户改为git:
    $ chown -R git:git test.git
    
  `4` 克隆仓库
    
    $ git clone git@172.16.55.131:/home/gitrepo/test.git
    Cloning into 'test'...
    warning: You appear to have cloned an empty repository.
    Checking connectivity... done.
    
  `5` 可以禁用 git 用户通过shell登录,可以通过编辑/etc/passwd文件完成。找到类似下面的一行:
  
    git:x:1001:1001::/home/git:/bin/bash
    改为：
    git:x:1001:1001::/home/git:/bin/git-shell    # git-shell每次一登录就自动退出
    或者:
    
    git:x:1001:1001::/home/git:/bin/nologin
    
    
    
   