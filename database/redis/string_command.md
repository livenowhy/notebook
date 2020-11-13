#### String 只读命令
    GET, GETRANGE, MGET, STRLEN, 


#### List 只读命令
    LINDEX, LLEN
    
    
#### Set 只读命令   
    SCARD, SINTER, SISMEMBER, SMEMBERS, SRANDMEMBER, SUNION, SSCAN
    

####
    ZCARD, ZCOUNT, ZLEXCOUNT, ZRANGE, ZRANGEBYLEX, ZRANGEBYSCORE, ZRANK, ZREVRANGE, ZREVRANGEBYSCORE, ZREVRANK, ZSCORE, ZSCAN
















18	ZSCORE key member 
返回有序集中，成员的分数值
19	ZUNIONSTORE destination numkeys key [key ...] 
计算给定的一个或多个有序集的并集，并存储在新的 key 中
20	ZSCAN key cursor [MATCH pattern] [COUNT count] 
迭代有序集合中的元素（包括元素成员和元素分值）
    

