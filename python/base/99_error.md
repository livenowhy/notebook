## 环境异常

  1. 环境部署及第三方包安装时报错错误
  
    error: Could not install packages due to an EnvironmentError: HTTPSConnectionPool

    $ mkdir $HOME/.pip
    $ vim pip.conf  添加一下内容
    [global]
    trusted-host = pypi.python.org
                   pypi.org
                   files.pythonhosted.org
                   
  2. 安装 lxml 报错

    fatal error: libxml/xpath.h: No such file or directory
    解决办法: apt-get install python-dev python3-dev libxml2-dev libxslt1-dev zlib1g-dev

  3. i686-linux-gnu-gcc
    
    error: command 'i686-linux-gnu-gcc' failed with exit status 1

    解决办法:
    pip install cython
    apt-get update
    apt-get install python-dev
    
    
  4. EnvironmentError: mysql_config not found
  
    mac
    $ brew install mysql
    $ pip install MySQL-Python
    
  
  5. fatal error: ffi.h: No such file or directory
     
    $ pip install scrapy   安装过程报错
    $ apt-get install libffi-dev -y (解决方法)
  
  6. -bash: make: command not found
    
    $ yum -y install gcc automake autoconf libtool make
 
  7. mac 配置 python 开发环境时异常 'openssl/err.h' file not found
 
    $ brew link openssl --force
    $ echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile
    $ export LDFLAGS="-L/usr/local/opt/openssl/lib"
    $ export CPPFLAGS="-I/usr/local/opt/openssl/include"
    $ pip3 install m2crypto


## 运行异常

  1. RecursionError 的最大递归深度错误

    RecursionError: maximum recursion depth exceeded in comparison

    File "/usr/local/python3/lib/python3.6/site-packages/bs4/element.py", line 1180, in decode
      indent_contents, eventual_encoding, formatter)

    import sys
    sys.getrecursionlimit()
    sys.setrecursionlimit(5000)

  2. IndexError

    IndexError: list index out of range
    jieba load_userdict word, freq = tup[0], tup[1]

    In [1]: import jieba
    In [2]: jieba.__version__
    Out[2]: '0.34'

    解决方法: 卸载重新安装