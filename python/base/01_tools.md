# python 开发工具及第三方包

## 一、由python代码生成UML类图

 `1` 首先安装graphviz，一个画图工具,地址为：

    http://www.graphviz.org/pub/graphviz/stable/windows/graphviz-2.28.0.msi

    $ yum install graphviz -y


  `2` pyreverse能方便的生成uml类图，pylint里自带了pyreverse这个工具。使用pip安装pylint

    $ pip install pylint

  `3` 使用，可以参考的命令为，ccc为存放代码的目录

    $ pyreverse -ASmy -o png ccc/
    
    
## 二、python 启动 ftp 服务
  
    $ pip install pyftpdlib
    $ python3  -m pyftpdlib
    访问: ftp://127.0.0.1:2121 即可, 127.0.0.1换成服务ip
    
## 三、selenium 配置

    $ pip install selenium
    $ pip install pyvirtualdisplay
    $ yum install -y chromedriver chromium xorg-x11-server-Xvfb
    
## 四、ubuntu 环境配置

    yum install -y python-simplejson
    pip install jieba
    pip install oss2
    pip install pillow
    pip install redis
    pip install django-celery
    pip install djangocms-installer
    pip install djangorestframework
    pip install commonware
    pip install ipython
    pip install newspaper3k
