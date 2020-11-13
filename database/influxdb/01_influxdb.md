# InfluxDB

    InfluxDB(时序数据库),常用的一种使用场景:监控数据统计。
    每毫秒记录一下电脑内存的使用情况,然后就可以根据统计的数据,利用图形化界面(InfluxDB V1一般配合Grafana)制作内存使用情况的折线图.
    可以理解为按时间记录一些数据(常用的监控数据、埋点统计数据等),然后制作图表做统计.

## 命令

    InfluxDB 数据库操作:
    1、进入命令行
    $ influx -precision rfc3339
    
    2、查看所有的数据库
    $ show databases;
    
    3、新建数据库
    $ create database prometheus

    4、使用特定的数据库
    $ use prometheus          # use database_name
    
    5、删除数据库
    $ drop database prometheus
    
    InfluxDB 数据表操作
    在 InfluxDB当中, 并没有表(table)这个概念，取而代之的是 MEASUREMENTS, MEASUREMENTS 的功能与传统数据库中的表一致.
    因此我们也可以将 MEASUREMENTS 称为 InfluxDB 中的表
    1、显示所有表
    $ show measurements;
    
    2、新建表 (InfluxDB 中没有显式的新建表的语句, 只能通过 insert 数据的方式来建立新表)
    $ insert disk_free,hostname=server01 value=442221834240i  (,前后没有空格)
    其中 disk_free 就是表名, hostname 是索引(tag), value=xx 是记录值(field), 记录值可以有多个,系统自带追加时间戳;
    或者添加数据时,自己写入时间戳
    $ insert disk_free,hostname=server01 value=442221834240i 1435362189575692182
    
    insert disk_free_demo,__name__=disk_free_demo,appname=node_exporter,device=dm-0,host=livenowhy,instance=node_exporter.livenowhy.com:80,job=node_exporter,user=guest value=442221834240i  (,前后没有空格)

    3、查询数据
    $ select * from measurement_name limit 10;   # select * from disk_free;
    
    4、数据中的时间字段默认显示的是一个纳秒时间戳，改成可读格式
    $ precision rfc3339;       之后再查询, 时间就是 rfc3339 标准格式
    或可以在连接数据库的时候，直接带该参数
    $ influx -precision rfc3339
    
    5、查看一个 measurement 中所有的 tag key
    $ show tag keys
    
    6、查看一个 measurement 中所有的 field key
    $ show field keys


    数据保存策略(Retention Policies)
    influxDB 是没有提供直接删除数据记录的方法，但是提供数据保存策略，主要用于指定数据保留时间，超过指定时间，就删除这部分数据。
    1、查看一个 measurement 中所有的保存策略(可以有多个, 一个标识为default)
    $ show retention policies;
    name    duration shardGroupDuration replicaN default
    ----    -------- ------------------ -------- -------
    autogen 0s       168h0m0s           1        true

    2、查看当前数据库 Retention Policies
    $ show retention policies on "prometheus"    # show retention policies on "db_name" 
    
    3、创建新的 Retention Policies
    $ create retention policy "rp_name" on "db_name" duration 3w replication 1 default
    rp_name: 策略名; 
    db_name: 具体的数据库名; 
    3w: 保存3周, 3周之前的数据将被删除, influxdb 具有各种事件参数, 比如:h(小时), d(天), w(星期)
    replication 1: 副本个数, 一般为1就可以了;
    default: 设置为默认策略
    
    4、修改 Retention Policies
    $ alter retention policy "rp_name" on "db_name" duration 30d default
    
    5、删除 Retention Policies
    $ drop retention policy "rp_name" on "db_name"
 


    连续查询(Continuous Queries)
    InfluxDB 的连续查询是在数据库中自动定时启动的一组语句, 语句中必须包含 SELECT 关键词和 GROUP BY time() 关键词。
    InfluxDB 会将查询结果放在指定的数据表中。
    目的: 使用连续查询是最优的降低采样率的方式，连续查询和存储策略搭配使用将会大大降低 InfluxDB 的系统占用量。
    而且使用连续查询后, 数据会存放到指定的数据表中，这样就为以后统计不同精度的数据提供了方便。
    
    1、新建连续查询
    $ CREATE CONTINUOUS QUERY <cq_name> ON <database_name>
    [RESAMPLE [EVERY <interval>] [FOR <interval>]]
    BEGIN SELECT <function>(<stuff>)[,<function>(<stuff>)] INTO <different_measurement> 
    FROM <current_measurement> [WHERE <stuff>] GROUP BY time(<interval>)[,<stuff>]
    END
    
    样例:
    CREATE CONTINUOUS QUERY wj_30m ON prometheus BEGIN SELECT mean(connected_clients), MEDIAN(connected_clients), MAX(connected_clients), MIN(connected_clients) INTO redis_clients_30m FROM redis_clients GROUP BY ip,port,time(30m) END
    在 prometheus 库中新建了一个名为 wj_30m 的连续查询，每三十分钟取一个connected_clients字段的平均值、中位值、最大值、最小值 redis_clients_30m 表中。使用的数据保留策略都是 default。
    
    不同 database 样例:
    CREATE CONTINUOUS QUERY wj_30m ON prometheus_30 BEGIN SELECT mean(connected_clients), MEDIAN(connected_clients), MAX(connected_clients), MIN(connected_clients) INTO shhnwangjian_30.autogen.redis_clients_30m FROM shhnwangjian.autogen.redis_clients GROUP BY ip,port,time(30m) END
    
    2、显示所有已存在的连续查询
    $ SHOW CONTINUOUS QUERIES
    
    3、删除 Continuous Queries
    $ DROP CONTINUOUS QUERY <cq_name> ON <database_name>