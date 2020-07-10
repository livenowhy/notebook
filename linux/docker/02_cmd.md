# docker 操作命令

## docker 删除所有容器

    $ docker rm `docker ps -a -q`

## 指定存储位置镜像存储位置

    修改 docker.service 文件,使用 -g 参数指定存储位置

    $ vi /usr/lib/systemd/system/docker.service
    ExecStart=/usr/bin/dockerd --graph /new-path/docker

    $ systemctl daemon-reload           # reload配置文件
    $ systemctl restart docker.service  # 重启docker
    $ docker info    #查看 Docker Root Dir: /var/lib/docker 是否改成设定的目录/new-path/docker
    
## 命令
    
    $ 容器有自己的内部网络和IP地址
    $ 使用docker inspect + 容器 ID 可以获取所有的变量值
    $ 在执行docker run的时候如果添加 --rm 标记,则容器在终止后会立即删除。注意, --rm 和 -d 参数不能同时使用
    $ 使用 --link 参数可以让容器之间安全的进行交互
    