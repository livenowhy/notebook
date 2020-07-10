## Django 获取 Header 中的信息

    request.META.get("header key") 用于获取header的信息

    注意的是header key必须增加前缀HTTP,同时大写,例如你的key为username,那么应该写成:
    request.META.get("HTTP_USERNAME")

    另外就是当你的header key中带有中横线,那么自动会被转成下划线,例如my-user的写成:
    request.META.get("HTTP_MY_USER")

    # 前端传入时 AccessToken 大写开头不能有下划线
    head_token = request.META.get("HTTP_ACCESSTOKEN")

#### Django 执行脚本

    脚本的路径必须为:
    app_name/management/commands

    例如,为apple引用创建脚本,路径为:
    /data/example/apple/management/commands/AutoDownloadImages.py

    代码如下:
    # -*- coding: utf-8 -*-
    from django.core.management.base import BaseCommand

    class Command(BaseCommand):
       def handle(self, *args, **options):
           print("gogo")


    执行方式:
    $/data/python-virtualenv/apple/bin/python /data/example/apple/manage.py AutoCheckTicket


