# django 基础

## 创建项目 及 创建应用

    $ django-admin startproject zcode  # 创建 zcode 项目
    $ cd zcode                         # 切换到 zcode 目录
    $ python3 manage.py startapp polls   # 创建 polls 应用

## 修改数据库配置

    $ vim settings.py  修改
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'flamingo',
            'USER': os.environ.get('MYSQL_USER', "root"),
            'HOST': os.environ.get('MYSQL_HOST', "basevm.livenowhy.com"),
            'PASSWORD': os.environ.get('MYSQL_PASSWORD', "openpass813"),
            'PORT': os.environ.get('MYSQL_PORT', 3306),
            'CONN_MAX_AGE': 600
        }
    }

## migrate 操作

    (添加 INSTALLED_APPS 和 DATABASES 之后)
    $ python3 manage.py migrate (先执行)
    
    ... models.py ... 添加 model
    $ python3 manage.py makemigrations
    $ python3 manage.py migrate

## 创建管理用户

    $ python3 manage.py createsuperuser  (管理员帐号)
