## redis 命令 Map 类型

   如果存储一个对象 这个时候使用String 类型就不适合了，如果在String中修改一个数据的话，这就感到烦琐。 
   
   hash 散列类型, 他提供了字段与字段值的映射，当然字段值只能是字符串类型

#### 命令 
  `1` 赋值

    HSET命令不区分插入和更新操作，当执行插入操作时HSET命令返回1，当执行更新操作时返回0。一次只能设置一个字段值 
    语法: HSET key field value
    127.0.0.1:6379> hset user username zhangsan 
    
    一次可以设置多个字段值
    语法: HMSET key field value [field value ...]
    127.0.0.1:6379> hmset user age 20 username lisi
    
    语法: HSETNX key field value
    127.0.0.1:6379> hsetnx user age 30  如果user中没有age字段则设置age值为30，否则不做任何操作


  `2` 取值 

    一次只能获取一个字段值
    
    语法: HGET key field
    127.0.0.1:6379> hget user username
    
    一次可以获取多个字段值
    语法: HMGET key field [field ...]
    127.0.0.1:6379> hmget user age username
    
    获取所有字段值
    语法: HGETALL key
    127.0.0.1:6379> hgetall user

  `3` 删除字段
  
    可以删除一个或多个字段，返回值是被删除的字段个数
    语法: HDEL key field [field ...]

    127.0.0.1:6379> hdel user age
    127.0.0.1:6379> hdel user age name
    127.0.0.1:6379> hdel user age username
    
    增加数字
    语法: HINCRBY key field increment
    127.0.0.1:6379> hincrby user age 2  将用户的年龄加2
    127.0.0.1:6379> hget user age       获取用户的年龄
    注: 这个没有递减数字这一说

  `4` 其他 
    判断字段是否存在
    语法: HEXISTS key field

    127.0.0.1:6379> hexists user age        查看user中是否有age字段
    127.0.0.1:6379> hexists user name       查看user中是否有name字段
    只获取字段名或字段值 
    语法： 
    HKEYS key 
    HVALS key

    127.0.0.1:6379> hkeys user
    127.0.0.1:6379> hvals user

    获取字段数量 
    语法：HLEN key