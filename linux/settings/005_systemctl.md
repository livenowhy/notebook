# 通过 systemctl 设置开机启动服务、永久性关闭服务

## 用法

  1、启动服务
  
    $ systemctl start NetworkManager

  2、开机启动服务
  
    $ systemctl enable NetworkManager

  3、停止服务

    $ systemctl stop NetworkManager

  4、永久性停止服务
    
    $ systemctl disable NetworkManager