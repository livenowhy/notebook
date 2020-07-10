# mysql kill process 解决死锁

## MySQL中大数据表增加字段

    MySQL中大数据表增加字段容易导致数据表锁死

## 查看进程列表, 找到ID

    > show processlist;
    --------------------------------------------------------------------------------------------+
    | Id     | User        | Host                  | db     | Command | Time  | State     | Info
    +--------+-------------+-----------------------+--------+---------+-------+-----------------+
    |     13 | aliyun_root | 127.0.0.1:63984       | NULL   | Sleep   |   129 |           | NULL
    | 772340 | bit         | 172.26.244.94:41788   | bitool | Sleep   | 11756 |           | NULL         | NULL
    > kill 772340;

## MySQL 大表加字段的思路如下：

`1` 创建一个临时的新表，首先复制旧表的结构（包含索引)

    > ALTER TABLE tbl_tpl ADD title(255) DEFAULT '' COMMENT '标题' AFTER id;

`2` 给新表加上新增的字段

`3` 把旧表的数据复制过来

    > insert into new_table(filed1, filed2 ...) select filed1,filed2, ... from old_table;

`4` 删除旧表，重命名新表的名字为旧表的名字
    
    > rename table old_table to old_table_bak1;
