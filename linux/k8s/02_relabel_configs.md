# promethus 的 relabel_configs 和 metric_relabel_configs
  
  relabel_configs 和 metric_relabel_configs 两个配置使用区别:
  
  `1` relabel_configs 是针对 target 指标采集前和采集中的筛选，
  `2` metric_relabel_configs 是针对指标采集后的筛选

    relabel_configs: 允许在采集之前对任何目标及其标签进行修改
    重新标签的意义:
    `1` 重命名标签名
    `2` 删除标签
    `3` 过滤目标
     
    action: 重新标签动作
     
    replace: 默认，通过regex匹配source_label的值，使用replacement来引用表达式匹配的分组
    keep: 删除regex与连接不匹配的目标 source_labels
    drop: 删除regex与连接匹配的目标 source_labels
    labeldrop: 删除regex匹配的标签
    labelkeep: 删除regex不匹配的标签
    hashmod: 设置target_label为modulus连接的哈希值source_labels
    labelmap: 匹配regex所有标签名称。然后复制匹配标签的值进行分组，replacement分组引用（${1},${2},…）替代
    
## 参考
    
    https://www.cnblogs.com/passzhang/p/12134346.html
    https://chenxy.blog.csdn.net/article/details/107301559
    https://www.cnblogs.com/faberbeta/p/13553810.html

