## Redis 键(key)

### Redis 键命令用于管理 redis 的键
   
    key 是 redis 的键, 不是一种数据类型

### 命令

  `1` DEL 删除
    
    DEL key [key ...] 
    删除给定的一个或多个 key, 不存在的 key 会被忽略.
    返回值: 被删除 key 的数量.
    
  `2`  DUMP 序列化给定 key
    
    DUMP key
    序列化给定 key, 并返回被序列化的值, 使用 RESTORE 命令可以将这个值反序列化为 Redis 键。
    返回值: 如果 key 不存在, 那么返回 nil; 否则, 返回序列化之后的值
    
  `3`  EXISTS 检查给定 key 是否存在
    
    EXISTS key
    返回值: 若 key 存在, 返回 1; 否则返回 0
    
  `4` KEYS 查找 key
    
    KEYS pattern    查找所有符合给定模式 (pattern) 的 key
    
  `5` MOVE
    
    MOVE key db    将当前数据库的 key 移动到给定的数据库 db 当中
    
  `6` TYPE  查看存储的数据类型
    
    TYPE key    返回 key 所储存的值的类型
    
  `7` TTL 以秒为单位, 返回给定 key 的剩余生存时间(TTL, time to live)
    
    TTL key
    
  `8` PTTL 以毫秒为单位返回 key 的剩余的过期时间
  
    PTTL key
  
  
  `9` EXPIRE 为给定 key 设置过期时间
  
    EXPIRE key seconds
    为给定 key 设置生存时间，当 key 过期时(生存时间为 0 ),它会被自动删除。
    在 Redis 中，带有生存时间的 key 被称为"易失的"(volatile)。
    生存时间可以通过使用 DEL 命令来删除整个 key 来移除, 或者被 SET 和 GETSET 命令覆写(overwrite)，
    这意味着，如果一个命令只是修改(alter)一个带生存时间的 key 的值而不是用一个新的 key 值来代替(replace)它的话，那么生存时间不会被改变。
    
    比如说,对一个 key 执行 INCR 命令，对一个列表进行 LPUSH 命令，或者对一个哈希表执行 HSET 命令，这类操作都不会修改 key 本身的生存时间。
    
    另一方面，如果使用 RENAME 对一个 key 进行改名，那么改名后的 key 的生存时间和改名前一样。
    
    RENAME 命令的另一种可能是，尝试将一个带生存时间的 key 改名成另一个带生存时间的 another_key ，这时旧的 another_key (以及它的生存时间)会被删除，然后旧的 key 会改名为 another_key ，因此，新的 another_key 的生存时间也和原本的 key 一样。
    
    使用 PERSIST 命令可以在不删除 key 的情况下，移除 key 的生存时间，让 key 重新成为一个『持久的』(persistent) key 。
    
    更新生存时间
    
    可以对一个已经带有生存时间的 key 执行 EXPIRE 命令，新指定的生存时间会取代旧的生存时间。
    
    过期时间的精确度
    
    在 Redis 2.4 版本中，过期时间的延迟在 1 秒钟之内 —— 也即是，就算 key 已经过期，但它还是可能在过期之后一秒钟之内被访问到，而在新的 Redis 2.6 版本中，延迟被降低到 1 毫秒之内。
    
    Redis 2.1.3 之前的不同之处
    
    在 Redis 2.1.3 之前的版本中，修改一个带有生存时间的 key 会导致整个 key 被删除，这一行为是受当时复制(replication)层的限制而作出的，现在这一限制已经被修复。
    
    返回值: 设置成功返回 1;
    当 key 不存在或者不能为 key 设置生存时间时(比如在低于 2.1.3 版本的 Redis 中你尝试更新 key 的生存时间)，返回 0 。
    
  `10` EXPIREAT
  
    EXPIREAT key timestamp 
    EXPIREAT 的作用和 EXPIRE 类似, 都用于为 key 设置过期时间.
    不同在于 EXPIREAT 命令接受的时间参数是 UNIX 时间戳(unix timestamp)
    
  `11` PEXPIRE 设置 key 的过期时间以毫秒计
  
    PEXPIRE key milliseconds
    
  `12` PEXPIREAT 设置 key 过期时间的时间戳(unix timestamp) 以毫秒计
    
    PEXPIREAT key milliseconds-timestamp
    
  `13` PERSIST
    
    PERSIST key  ;移除 key 的过期时间, key 将持久保持
    
  `14` RENAMENX
 
    RENAMENX 修改 key 的名称
    RENAMENX key newkey
    仅当 newkey 不存在时, 将 key 改名为 newkey
    
  `15` RENAME
  
    RENAME key newkey   修改 key 的名称
    
  `16` RANDOMKEY
    
    RANDOMKEY  从当前数据库中随机返回一个 key
    
  `17` SCAN 迭代数据库中的数据库键
    
    SCAN cursor [MATCH pattern] [COUNT count]
    cursor: 游标
    pattern: 匹配的模式
    count: 指定从数据集里返回多少元素, 默认值为 10