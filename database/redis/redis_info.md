#### Redis info 信息详解
    command: INFO [section]
    以一种易于解释(parse)且易于阅读的格式，返回关于 Redis 服务器的各种信息和统计数值。
    通过给定可选的参数 section ,可以让命令只返回某一部分的信息:
    
    47.92.132.113:8001[15]> info
    # Server  server 部分记录了 Redis 服务器的信息
    redis_version:4.0.10                                # Redis 服务器版本
    
    redis_git_sha1:00000000                             # Git SHA1
    
    redis_git_dirty:0                                   # Git dirty flag
    
    redis_build_id:3e68f04515f466a2
    
    redis_mode:standalone
    
    os:Linux 3.10.0-862.6.3.el7.x86_64 x86_64           # Redis 服务器的宿主操作系统
    
    arch_bits:64                                        # 架构(32 或 64 位)
    
    multiplexing_api:epoll                              # Redis 所使用的事件处理机制
    
    atomicvar_api:atomic-builtin
    
    gcc_version:6.3.0                                   # 编译 Redis 时所使用的 GCC 版本
    
    process_id:1                                        # 服务器进程的 PID
    
    run_id:accdb2e97960cf39a21c24e392a2c5871a6faba9     # Redis 服务器的随机标识符(用于 Sentinel 和集群)
    
    tcp_port:6379                                       # TCP/IP 监听端口
    
    uptime_in_seconds:10039875                          # 自 Redis 服务器启动以来，经过的秒数
    
    uptime_in_days:116                                  # 自 Redis 服务器启动以来，经过的天数
    
    hz:10
    
    lru_clock:2916355                                   # 以分钟为单位进行自增的时钟，用于 LRU 管理
    
    executable:/data/redis-server
    config_file:/data/redis.conf
    
    # Clients  部分记录了已连接客户端的信息
    connected_clients:89                               # 已连接客户端的数量(不包括通过从属服务器连接的客户端)
    
    client_longest_output_list:0                       # 当前连接的客户端当中，最长的输出列表
    
    client_biggest_input_buf:0                         # 当前连接的客户端当中，最大输入缓存
    
    blocked_clients:1                                  # 正在等待阻塞命令(BLPOP、BRPOP、BRPOPLPUSH)的客户端的数量
    
    # Memory    部分记录了服务器的内存信息
    used_memory:16419344                               # 由 Redis 分配器分配的内存总量，以字节(byte)为单位
    
    used_memory_human:15.66M                           # 以人类可读的格式返回 Redis 分配的内存总量
    
    used_memory_rss:38891520                           # 从操作系统的角度，返回 Redis 已分配的内存总量(俗称常驻集大小).
                                                       # 这个值和 top 、 ps 等命令的输出一致.
                                                       
    used_memory_rss_human:37.09M
    
    used_memory_peak:2000070784                        # Redis 的内存消耗峰值(以字节为单位)
    
    used_memory_peak_human:1.86G                       # 以人类可读的格式返回 Redis 的内存消耗峰值
    
    used_memory_peak_perc:0.82%
    
    used_memory_overhead:3842238
    used_memory_startup:786568
    used_memory_dataset:12577106
    used_memory_dataset_perc:80.45%
    total_system_memory:8201953280                      # 系统内存
    total_system_memory_human:7.64G
    used_memory_lua:37888                               # Lua 引擎所使用的内存大小(以字节为单位)
    used_memory_lua_human:37.00K
    
    maxmemory:2000000000                                # 给 redis 分配的内存上限
    
    maxmemory_human:1.86G
    maxmemory_policy:volatile-lru
    mem_fragmentation_ratio:2.37                        # used_memory_rss 和 used_memory 之间的比率
    # 在理想情况下， used_memory_rss 的值应该只比 used_memory 稍微高一点儿.
    # 当 rss > used ，且两者的值相差较大时，表示存在（内部或外部的）内存碎片
    # 内存碎片的比率可以通过 mem_fragmentation_ratio 的值看出.
    # 当 used > rss 时，表示 Redis 的部分内存被操作系统换出到交换空间了，在这种情况下，操作可能会产生明显的延迟
    # 当 Redis 释放内存时，分配器可能会，也可能不会，将内存返还给操作系统。
    # 如果 Redis 释放了内存，却没有将内存返还给操作系统，那么 used_memory 的值可能和操作系统显示的 Redis 内存占用并不一致。
    # 查看 used_memory_peak 的值可以验证这种情况是否发生。


    mem_allocator:jemalloc-4.0.3                        # 在编译时指定的,Redis 所使用的内存分配器.
                                                        # 可以是 libc 、 jemalloc 或者 tcmalloc
                                                        
    active_defrag_running:0
    lazyfree_pending_objects:0    
    
    # Persistence        部分记录了跟 RDB 持久化和 AOF 持久化有关的信息
    loading:0                              # 一个标志值，记录了服务器是否正在载入持久化文件
    
    rdb_changes_since_last_save:3084       # 距离最近一次成功创建持久化文件之后，经过了多少秒
    
    rdb_bgsave_in_progress:0               # 一个标志值，记录了服务器是否正在创建 RDB 文件
    
    rdb_last_save_time:1546419940          # 最近一次成功创建 RDB 文件的 UNIX 时间戳
    
    rdb_last_bgsave_status:ok              # 一个标志值，记录了最近一次创建 RDB 文件的结果是成功还是失败
    
    rdb_last_bgsave_time_sec:0             # 记录了最近一次创建 RDB 文件耗费的秒数
    
    rdb_current_bgsave_time_sec:-1         # 如果服务器正在创建 RDB 文件，那么这个域记录的就是当前的创建操作已经耗费的秒数
    
    rdb_last_cow_size:5242880
    
    aof_enabled:0                          # 一个标志值，记录了 AOF 是否处于打开状态
    
    aof_rewrite_in_progress:0              # 一个标志值，记录了服务器是否正在创建 AOF 文件
    
    aof_rewrite_scheduled:0                # 一个标志值，记录了在 RDB 文件创建完毕之后，是否需要执行预约的 AOF 重写操作
    
    aof_last_rewrite_time_sec:-1           # 最近一次创建 AOF 文件耗费的时长
    
    aof_current_rewrite_time_sec:-1        # 如果服务器正在创建 AOF 文件，那么这个域记录的就是当前的创建操作已经耗费的秒数
    
    aof_last_bgrewrite_status:ok           # 一个标志值，记录了最近一次创建 AOF 文件的结果是成功还是失败
    
        # 如果 AOF 持久化功能处于开启状态，那么这个部分还会加上以下域:
        aof_current_size : AOF 文件目前的大小。
        aof_base_size : 服务器启动时或者 AOF 重写最近一次执行之后，AOF 文件的大小。
        aof_pending_rewrite : 一个标志值，记录了是否有 AOF 重写操作在等待 RDB 文件创建完毕之后执行。
        aof_buffer_length : AOF 缓冲区的大小。
        aof_rewrite_buffer_length : AOF 重写缓冲区的大小。
        aof_pending_bio_fsync : 后台 I/O 队列里面，等待执行的 fsync 调用数量。
        aof_delayed_fsync : 被延迟的 fsync 调用数量。
    
    aof_last_write_status:ok
    aof_last_cow_size:0
    
    
    # Stats   部分记录了一般统计信息
    total_connections_received:1938669        # 服务器已接受的连接请求数量
    
    total_commands_processed:4755316486       # 服务器已执行的命令数量
    
    instantaneous_ops_per_sec:388             # 服务器每秒钟执行的命令数量
    
    total_net_input_bytes:251155350431
    total_net_output_bytes:383719479797
    instantaneous_input_kbps:36.17
    instantaneous_output_kbps:2.53
    rejected_connections:0                    # 因为最大客户端数量限制而被拒绝的连接请求数量
    
    sync_full:0
    sync_partial_ok:0
    sync_partial_err:0
    expired_keys:7948435                      # 因为过期而被自动删除的数据库键数量
    expired_stale_perc:0.02
    expired_time_cap_reached_count:12
    
    evicted_keys:143285                       # 因为最大内存容量限制而被驱逐(evict)的键数量,运行以来删除过的key的数量
    
    keyspace_hits:251094102                   # 查找数据库键成功的次数, 命中 key 的次数
    
    keyspace_misses:105657120                 # 查找数据库键失败的次数, 不命中 key 的次数
    
    pubsub_channels:0                         # 目前被订阅的频道数量
    
    pubsub_patterns:3                         # 目前被订阅的模式数量
    
    latest_fork_usec:4227                     # 最近一次 fork() 操作耗费的毫秒数
    
    migrate_cached_sockets:0
    slave_expires_tracked_keys:0
    active_defrag_hits:0
    active_defrag_misses:0
    active_defrag_key_hits:0
    active_defrag_key_misses:0

    
    # Replication   主/从复制信息
    role:master                                                # 如果当前服务器没有在复制任何其他服务器，那么这个域的值就是 master;
                                                               # 否则的话, 这个域的值就是 slave
                                                               注意，在创建复制链的时候，一个从服务器也可能是另一个服务器的主服务器。
                                                               # 如果当前服务器是一个从服务器的话，那么这个部分还会加上以下域:                                               
        master_host: 主服务器的 IP 地址。
        master_port: 主服务器的 TCP 监听端口号。
        master_link_status : 复制连接当前的状态， up 表示连接正常， down 表示连接断开。
        master_last_io_seconds_ago: 距离最近一次与主服务器进行通信已经过去了多少秒钟。
        master_sync_in_progress: 一个标志值，记录了主服务器是否正在与这个从服务器进行同步。
        如果同步操作正在进行，那么这个部分还会加上以下域:
        
        master_sync_left_bytes : 距离同步完成还缺少多少字节数据。
        master_sync_last_io_seconds_ago : 距离最近一次因为 SYNC 操作而进行 I/O 已经过去了多少秒。
        如果主从服务器之间的连接处于断线状态，那么这个部分还会加上以下域：
        
        master_link_down_since_seconds : 主从服务器连接断开了多少秒。
        以下是一些总会出现的域:
        
        connected_slaves: 已连接的从服务器数量。
        对于每个从服务器，都会添加以下一行信息: 
        slaveXXX:  ID、IP 地址、端口号、连接状态
                                             
    connected_slaves:0
    master_replid:2a55562d9821886b0dbed62673b7de217d06aa64
    master_replid2:0000000000000000000000000000000000000000
    master_repl_offset:0
    second_repl_offset:-1
    repl_backlog_active:0
    repl_backlog_size:1048576
    repl_backlog_first_byte_offset:0
    repl_backlog_histlen:0
    
    
    # CPU    部分记录了 CPU 的计算量统计信息
    used_cpu_sys:62699.97             # Redis 服务器耗费的系统 CPU; redis进程指令在核心态所消耗的cpu时间, 该值为累计值(秒)
    used_cpu_user:27818.10            # Redis 服务器耗费的用户 CPU; redis进程指令在用户态所消耗的cpu时间, 该值为累计值(秒)
    used_cpu_sys_children:1837.79     # 后台进程耗费的系统 CPU; redis后台进程指令在核心态所消耗的cpu时间, 该值为累计值(秒)
    used_cpu_user_children:14497.01   # 后台进程耗费的用户 CPU; redis后台进程指令在用户态所消耗的cpu时间, 该值为累计值(秒)
    
    
    redis默认是单线程运行的，为了充分利用机器的cpu，正常情况下一台服务器上会装多个实例。、
    如果通过top命令监控机器的cpu的话，监控值很笼统，不能精确到单redis实例的cpu使用率监控。
    而且centos 7.0通过top监控整体cpu的使用率并不准确。所以需要使用其它方式监控cpu。

    redis进程单cpu的消耗率可以通过如下公式计算:
    ((used_cpu_sys_now-used_cpu_sys_before)/(now-before))*100

    可以通过下面的方式计算告警值：
    (used_cpu_sys_now-used_cpu_sys_before)/(now-before)<0.9

    其中:
    used_cpu_sys_now:now时间点的 used_cpu_sys 值
    used_cpu_sys_before:before时间点的used_cpu_sys值
    
    
    # commandstats 部分记录了各种不同类型的命令的执行统计信息，比如命令执行的次数、命令耗费的 CPU 时间、执行每个命令耗费的平均 CPU 时间等等。
    # 对于每种类型的命令，这个部分都会添加一行以下格式的信息:
    cmdstat_XXX:calls=XXX,usec=XXX,usecpercall=XXX
    
    # Cluster   部分记录了和集群有关的信息
    cluster_enabled:0           # 一个标志值，记录集群功能是否已经开启
    
    # Keyspace  部分记录了数据库相关的统计信息, 比如数据库的键数量、数据库已经被删除的过期键数量等
                对于每个数据库，这个部分都会添加一行以下格式的信息:
    # 各个数据库的 key 的数量, 以及带有生存期的 key 的数量
    db0:keys=3,expires=0,avg_ttl=0
    db10:keys=6,expires=0,avg_ttl=0
    db11:keys=6169,expires=6166,avg_ttl=41353282
    db12:keys=8504,expires=0,avg_ttl=0
    db13:keys=2,expires=2,avg_ttl=293336
    db15:keys=7,expires=0,avg_ttl=0
    
    
    除上面给出的这些值以外, section 参数的值还可以是下面这两个:
    
    all : 返回所有信息
    default : 返回默认选择的信息
    当不带参数直接调用 INFO 命令时，使用 default 作为默认参数。
    
    不同版本的 Redis 可能对返回的一些域进行了增加或删减。
    因此，一个健壮的客户端程序在对 INFO 命令的输出进行分析时，应该能够跳过不认识的域，并且妥善地处理丢失不见的域。
       