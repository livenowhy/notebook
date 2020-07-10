# Django 基础

## docker 容器部署 uwsgi docker 容器启动后马上退出解决方案

    当在 docker 中使用 uwsgi 时，如果在 uwsgi.ini 配置文件中指定了 daemonize 参数，
    容器的 uwsgi 应用的日志将会输出到指定的文件， 进程会在后台运行，而不是在前台运行，
    这样就造成通过docker run启动或者compose启动时容器立刻退出的情况。
    如果是 django.xml 文件则要注释 <!-- <daemonize> uwsgi.log</daemonize> -->

## Debug 设置为 False 后静态文件获取 404
  
  当设置 setting.py 文件当中的 DEBUG=FALSE 后，Django 会默认使用 Web Server 的静态文件处理，故若没设置好 Web Server 对静态文件的处理的话，会出现访问静态文件404的情况。
  可以通过设置 --insecure 参数解决

    ~$ python manage.py runserver --insecure

## django 引用 static 目录下的 css,js 文件 304 问题

  css,js文件304导致无法加载显示问题
  前提: django1.8

  在html页面可以请求道css, js文件并在chrome的开发者工具中查看css,js文件返回状态为 200
  原因:
  
    html页面在头部添加了<!DOCTYPE html>申明导致css样式加载不起效果，去掉此标签css效果起作用.