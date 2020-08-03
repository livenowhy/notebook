# rabbitmqadmin

## rabbitmqadmin安装


### rabbitmqadmin 帮助页面

    http://www.rabbitmq.com/management-cli.html

### 按照

    $ wget http://xxx:15672/cli/rabbitmqadmin    # 可下载 rabbtimqadmin 脚本
    
### rabbitmqadmin 命令

    rabbitmqadmin list users                # 查看用户列表
    rabbitmqadmin list vhosts               # 查看 vhosts
    rabbitmqadmin list connections          # 查看 connections
    rabbitmqadmin list exchanges            # 查看 exchanges
    rabbitmqadmin list bindings             # 查看 bindings
    rabbitmqadmin list permissions          # 查看 permissions
    rabbitmqadmin list channels             # 查看 channels
    rabbitmqadmin list parameters           # 查看 parameters
    rabbitmqadmin list consumers            # 查看 consumers
    rabbitmqadmin list queues               # 查看 queues
    rabbitmqadmin list policies             # 查看 policies
    rabbitmqadmin list nodes                # 查看 nodes
    rabbitmqadmin show overview             # 查看 overview
    
    使用 -f 可以指定格式
    有如下几种格式 raw_json, long, pretty_json, kvp, tsv, table, bash 默认为 table
    $ rabbitmqadmin -f long list users

    --------------------------------------------------------------------------------
                 name: apipd_user
    hashing_algorithm: rabbit_password_hashing_sha256
        password_hash: 1zS7wp/Z8oWfW
                 tags:
    --------------------------------------------------------------------------------
                 name: apipre_user
    hashing_algorithm: rabbit_password_hashing_sha256
        password_hash: YCnAoTa
                 tags:
    --------------------------------------------------------------------------------

    查看 queues
    [root@rabbitmq1 sbin]# rabbitmqadmin list queues
    +-------------------------------------------------------------------+----------+
    |                               name                                | messages |
    +-------------------------------------------------------------------+----------+
    | celeryev.3c8bcb11-45b8-4ad6-b8bf-5e4673b22989                     | 0        |
    | default_handle_queue                                              | 1        |
    | sync_alert_relation_queue                                         | 1        |
    +-------------------------------------------------------------------+----------+
    
    # 删除队列
    $ rabbitmqadmin delete queue name=sync_alert_relation_queue --vhost apipd
    

    # 查看bindings
    $ rabbitmqadmin list bindings
    +---------------------------+-------------------------------------------------------------------+-------------------------------------------------------------------+
    |          source           |                            destination                            |                            routing_key                            |
    +---------------------------+-------------------------------------------------------------------+-------------------------------------------------------------------+
    |                           | celeryev.01138b9a-3dae-47fe-8cbb-14d16dd7e592                     | celeryev.01138b9a-3dae-47fe-8cbb-14d16dd7e592                     |
    | sync_ali_queue            | sync_ali_queue                                                    | sync_ali_queue                                                    |
    | sync_hw_queue             | sync_hw_queue                                                     | sync_hw_queue                                                     |
    | unbind_model_queue        | unbind_model_queue                                                | unbind_model_queue                                                |
    +---------------------------+-------------------------------------------------------------------+-------------------------------------------------------------------+
    
    删除所有队列
    $ rabbitmqadmin -f tsv -q list queues name | while read queue; do rabbitmqadmin --vhost apipre -q delete queue name=${queue}; done