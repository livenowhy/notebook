## redis 异常

#### 配额
    
    (error) MISCONF Redis is configured to save RDB snapshots, but is currently not able to persist on disk.
    
    运行Redis时发生错误，错误信息如下:
    (error) MISCONF Redis is configured to save RDB snapshots, but is currently not able to persist on disk. Commands that may modify the data set are disabled. Please check Redis logs for details about the error.
    
    Redis被配置为保存数据库快照，但它目前不能持久化到硬盘。用来修改集合数据的命令不能用。请查看Redis日志的详细错误信息。

    原因:强制关闭Redis快照导致不能持久化。
    
    解决方案:
    运行 config set stop-writes-on-bgsave-error no　命令后，关闭配置项 stop-writes-on-bgsave-error 解决该问题。

    # ./redis-cli
    127.0.0.1:6379> config set stop-writes-on-bgsave-error no
    OK
    127.0.0.1:6379> lpush myColour "red"
    (integer) 1

#### 内存
    
    redis Preparing to test memory region

    maxmemory 2mb
    maxmemory-policy volatile-lru

