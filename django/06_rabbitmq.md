
# rabbitMQ 操作
## 批量删除指定的队列
    首先进入到rabbitmq目录下的sbin目录
    方法1：
    ./rabbitmqctl list_queues --vhost apipd | awk '{print $1}' | xargs -n1 rabbitmqctl  --timeout 20 --vhost apipd delete_queue c3d369abd00f498ba102560421597144
    
    
    rabbitmqctl --vhost apipd list_queues name | while read name; do rabbitmqctl -q delete queue name=${queue}; done
