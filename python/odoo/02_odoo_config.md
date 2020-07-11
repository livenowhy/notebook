# Odoo 服务器配置文件

  在默认情况下, Odoo 使用 .odoorc 文件来保存配置参数。
  在 Ubuntu 系统中，该文件存储于 /home/odoo/ 路径下。


  为了更方便非 root 用户远程登录使用，我们可以在 Ubuntu 中修改一下 .odoorc 文件的路径，由用户的 home 路径修改到 /etc 下面:

    $ sudo mkdir /etc/odoo
    $ sudo cp /home/odoo/.odoorc /etc/odoo/odoo.conf
    $ sudo chown -R odoo /etc/odoo


  配置文件一些重要的参数具体解释如下:

    ·addons_path: 使用逗号 (,) 分隔扩展路径，会在路径中寻找模块，从左至右阅读，最左侧拥有最高的优先级。
    ·admin_passwd: 是 master 的主控密码, 可用于访问 Web 客户端数据库管理。建议设置一个安全性足够强的密码，设置为 False 会使此功能失效.
    ·db_user: 数据库实例,在服务器启动序列期间进行初始化。
    ·dbfilter: 用于筛选可访问的数据库，它是Pythoninterpreted正则表达式，用于不让用户选择数据库，以及使未验证的 URL 能够正常工作，它应该以^dbname$格式进行设置，例如 dbfilter=^odoo-prod$。它支持%h和%d占位符，可用来作为HTTP请求的主机名和子域名。
    ·logfile: Odoo 服务日志写入的地方。系统的服务日志通常位于/var/log中，若留空，或者设置为False，则日志会以标准方式进行输出。
    ·logrotate=True: 表示按天存放日志。
    ·proxy_mode: 当使用反向代理时,应将其设为True。
    ·without_demo: 在生产环境中应将其设为True，这样新的数据库中就不会再有演示数据。
    ·workers: 其值为启用的处理器数量。
    ·xmlrpc_port: 服务监听的端口号。默认使用8069。
    ·data_dir: 会话数据和附件存储的位置，应记得备份它。
    ·xmlrpc-interface: 设置监听的地址。默认值会监听所有端口 0.0.0.0, 在使用反向代理时，可以设置为127.0.0.1，目的是只对本地请求响应。


## 安装模块

  已经安装好的Odoo相当于一个ERP系统的平台，但是还不具备直接使用的能力，因为企业的业务多种多样，所以需要根据自己的业务特点选择需要的模块进行安装，应用菜单内已有的模块直接安装即可，没有的模块则需要我们单独下载或自行开发后安装。

## 配置模块插件路径

如果需要安装一个安装时没有的（也就是当前在应用内搜索不到的）模块，那么需要先找到该模块的包，然后复制到odoo11/addons/路径下，最后重启就可以看到新复制过来的模块了。
不过，最好不要那样做，因为我们采用的是源码安装方式，也就是说我们在 addons 路径下的包与GitHub上的包是一样的，后续还可以更新。如果我们将第三方或者自开发的模块安装在这里，那么会导致整个工程的后续难以运维:

一般的做法是单独配置一个或多个路径提供给自开发或第三方模块使用。比如新建一个my-modules路径，然后配置到odoo.conf文件内，命令如下：

    $ vi /etc/odoo/odoo.conf
    [options]
    addons_path = /home/odoo11/odoo/addons,/home/odoo11/addons,/home/odoo11/my-modules

在参数addons_path上增加刚刚创建的路径就可以了，如果有多个则用逗号隔开。

注意: 因为在前面作者复制了.odoorc文件并改名为odoo.conf，所以请读者在使用时根据自己的实际情况进行操作，也可以直接使用.odoorc文件。


