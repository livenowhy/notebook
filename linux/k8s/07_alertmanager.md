# Alertmanager
## AlertManager 介绍

  Alertmanager 处理由客户端应用程序(例如Prometheus服务器)发送的警报。
  它负责将重复数据删除,分组和路由到正确的接收者,通知方式有电子邮件、短信、微信等。它还负责沉默和禁止警报。
  Altermanager有以下几个功能点:

  1、分组
  当机房网络故障时，或者机房断电时，会突然有大量相同的告警出现，此时就需要对告警进行分组聚合，整合成少量告警发出。
  每个告警信息中会列出受影响的服务或者机器。

  2、抑制(Inhibition)
  当集群故障时，会引发一系列告警，此时只需要通知集群故障，其它因为集群故障引起的告警应该被抑制，避免干扰判断。

  3、静默(Silences)
  当集群升级、服务更新的过程中，大概率导致告警。因此在升级期间，对这些告警进行静默，不再发送相关告警。
  

## altermanager 配置文件
    # global 指定了默认的接收者配置项
    global:
      # 默认smtp 配置项, 如果 recivers 中没有配置则采用全局配置项 
      [ smtp_from: <tmpl_string> ]
      [ smtp_smarthost: <string> ]
      [ smtp_hello: <string> | default = "localhost" ]
      [ smtp_auth_username: <string> ]
      [ smtp_auth_password: <secret> ]
      [ smtp_auth_identity: <string> ]
      [ smtp_auth_secret: <secret> ]
      [ smtp_require_tls: <bool> | default = true ]

      # 企业微信告警配置
      [ wechat_api_url: <string> | default = "https://qyapi.weixin.qq.com/cgi-bin/" ]
      [ wechat_api_secret: <secret> ]
      [ wechat_api_corp_id: <string> ]
  
      # 默认http客户端配置,不推荐配置。参考官方文档: https://prometheus.io/docs/alerting/latest/clients/
      [ http_config: <http_config> ]

      # 如果警报不包含 EndsAt, 则 ResolveTimeout 是 Alertmanager 使用的默认值, 经过此时间后,如果尚未更新,则可以将警报声明为已解决.
      # 这对 Prometheus 的警报没有影响，因为它们始终包含 EndsAt.
      [ resolve_timeout: <duration> | default = 5m ]
      
    在全局配置中需要注意的是 resolve_timeout, 该参数定义了当 Alertmanager 持续多长时间未接收到告警后标记告警状态为 resolved(已解决)。
    该参数的定义可能会影响到告警恢复通知的接收时间, 读者可根据自己的实际场景进行定义, 其默认值为5分钟。

    # 定义通知模板, 最好一个列表元素可以使用 Linux 通配符, 如 *.tmpl
    templates:
      [ - <filepath> ... ]
    
    # 定义路由
    route: <route>
        
    # 定义通知的接收者
    receivers:
      - <receiver> ...
        
    # 告警抑制规则
    inhibit_rules:
      [ - <inhibit_rule> ... ]
            
## 路由配置
  
  每个警报都会在已配置的顶级路由处进入路由树，该路由树必须与所有警报匹配(即没有任何已配置的匹配器)。
  然后遍历子节点。如果将 continue 设置为false，它将在第一个匹配的子项之后停止。
  如果在匹配的节点上true为true, 则警报将继续与后续的同级进行匹配。
  如果警报与节点的任何子节点都不匹配(不匹配的子节点或不存在子节点),则根据当前节点的配置参数来处理警报。
  
    # 告警接收者
    [ receiver: <string> ]
    # 告警根据标签进行分组，相同标签的作为一组进行聚合，发送单条告警信息。特殊值 '...' 表示告警不聚合
    [ group_by: '[' <labelname>, ... ']' ]
    
    # 告警是否匹后续的同级节点，如果为true还会继续进行规则匹配，否则匹配成功就截止
    [ continue: <boolean> | default = false ]
    
    # 报警必须匹配到labelname，否则无法匹配到该组路由，一般用于发送给不同联系人时使用
    match:
      [ <labelname>: <labelvalue>, ... ]
    match_re:
      [ <labelname>: <regex>, ... ]
    
    # 第一次发送当前group报警等待的时间，目的是实现同组告警的聚合
    [ group_wait: <duration> | default = 30s ]
    
    # 当上一次group告警发送成功后，该组又出现新的告警，那么等待多久再发送，一般设置为 5 分钟或者更久
    [ group_interval: <duration> | default = 5m ]
    
    # 已经发送成功的告警，但是一直没消除，那么等待多久再发送。一般推荐三个小时以上
    [ repeat_interval: <duration> | default = 4h ]
    
    # 子路由
    routes:
      [ - <route> ... ]

 
## 告警抑制(inhibit_rules)配置
  告警抑制是针对,系统已经发出A告警,对后续出现的由A告警引发的B告警进行抑制。
  流程就是:满足 source_match[_re] 的 A 告警已触发，B告警满足 target_match[_re],
  且A和B在 equal 列表中的标签值全部相等，此时抑制告警B。需要注意的是，空值标签和缺少这个标签的值在语义上是相等的！

    target_match:
      [ <labelname>: <labelvalue>, ... ]
    target_match_re:
      [ <labelname>: <regex>, ... ]
      
    source_match:
      [ <labelname>: <labelvalue>, ... ]
      
    source_match_re:
      [ <labelname>: <regex>, ... ]
    [ equal: '[' <labelname>, ... ']' ]
    
    
## 配置文件

    global:
      resolve_timeout: 5m    # 恢复的超时时间,这个跟告警恢复通知有关,此参数并不是说在这个时间没有收到告警就会恢复
    
    route:
      group_by: ['alertname']    # 默认以告警名进行分组,就是rule文件的alert值进行分组
      group_wait: 10s            # 发送警报前，至少等待多少秒才会发送(为了收集同组更多的警报信息一起发送)
      group_interval: 10s        # 如果警报1已经发送,这时又出现同组的警报2,由于组状态发生变化,警报会在group_interval这个时间内发送,不会被repeat_interval这个时间收敛
      repeat_interval: 20m       # 报警信息已发送，但事件并没有恢复,则等待多久时间再重新发送(生产环境一般设成20min或者30min)
      receiver: 'web.hook'       # 发送警报的接收者名称,如果一个报警没有被一个route匹配,则发送给默认的接收器
      
    receivers:    # 发送告警信息给那个接收者
      - name: 'web.hook'    # 这个需要和上面定义的接收者名称一致
        webhook_configs:
        - url: 'http://127.0.0.1:5001/'
    inhibit_rules:    # 抑制规则,防止告警风暴
      - source_match:
        severity: 'critical'
        target_match:
        severity: 'warning'
        equal: ['alertname', 'dev', 'instance']