# 使用第三方组件(django-redis)创建连接池

## 使用方法

    1. settings 里面 redis配置
    CACHES={
        'default':{
            'BACKEND':'django_redis.cache.RedisCache',
            'LOCATION':'redis://127.0.0.1:6379',
            'OPTIONS':{
                'CLIENT_CLASS': 'django_redis.client.DefaultClient',
                'CONNECTION_POOL_KWARGS': {"max_connections":100},
                "PASSWORD": "密码",
            }
        },
    }

    default是连接池的名称,可以在往后面加连接池，名称可以修改


    2. views 里面的使用

    import redis
    from django_redis import get_redis_connection
    from django.shortcuts import HttpResponse

    def index(request):
        conn=get_redis_connection('default')#default是连接池的名称
        return  HttpResponse('连接成功')