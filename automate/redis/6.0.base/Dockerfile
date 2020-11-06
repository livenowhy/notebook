FROM registry.cn-zhangjiakou.aliyuncs.com/livenowhy/redis:6.0

MAINTAINER livenowhy livenowhy@hotmail.com

COPY redis.conf /etc/redis/redis.conf
CMD [ "redis-server", "/etc/redis/redis.conf" ]

# docker run --name some-redis -d registry.cn-zhangjiakou.aliyuncs.com/livenowhy/redis:6.0.base