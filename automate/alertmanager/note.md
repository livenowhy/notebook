# Alertmanager

    Alertmanager 用于发送告警, 是真正发送信息给用户的模块.
    Alertmanager 会接受 Prometheus 发送过来的警告信息, 再由 Alertmanager 来发送.

## Alertmanager 特性

    Grouping - 分组
    防止告警风暴, 达到告警收敛目的
    设置时间段, 对接收到的同类告警只发送一条, 系统出问题同类告警只发送一条
    配置文件配置
    
    Inhibition - 抑制
    防止告警风暴, 达到告警收敛目的
    同一时间内, 对准备发送的告警事件的相关性, 决定只发送一条
    若A发送C不可达已经准备发送时，可配置其他关于C不可达事件不发送
    配置文件配置
    
    Silences - 沉默
    临时屏蔽, 设置某个时间段内某类告警不发送
    web界面配置
    
    Client behavior - 客户端
    POST方法, 两个接口v1、v2


## Alertmanager 关键 key 说明

    [
        {
            "labels": 
            {
                "alertname": "<requiredAlertName>",
                "<labelname>": "<labelvalue>",
                ...
            },
            "annotations": 
            {
                "<labelname>": "<labelvalue>",
            },
            "startsAt": "<rfc3339>",
            "endsAt": "<rfc3339>",
            "generatorURL": "<generator_url>"
        },
        ...
    ]
    
    labels: 代表一个告警事件, 用去去重
    annotations: 不代表一条告警, 用于完善告警详情
    startAt: 默认是接收告警事件的当前时间
    endsAt: 默认设置为可配置的超时时间，告警事件解决的时间
    generatorURL: 代表发送告警事件的客户端
    
## Alertmanager 配置

    global:
        smtp_smarthost: 'smtp.exmail.qq.com:25'       # smtp地址
        smtp_from: 'sijy@jubaozhu.com'                # 谁发邮件
        smtp_auth_username: 'sijy@jubaozhu.com'       # 邮箱用户
        smtp_auth_password: 'xxxxx'                   # 邮箱密码
        smtp_require_tls: false

    route:
        group_by: ["instance"]            # 分组名; 将传入警报分组的标签. 例如, 将有个针对 cluster = A 和 alertname = LatencyHigh 的警报进入批处理成一个组
        continue: false                   # 告警是否去继续路由子节点
        group_wait: 30s                   # 当收到告警的时候，等待三十秒看是否还有告警，如果有就一起发出去
        group_interval: 5m                # 发送警告间隔时间
        repeat_interval: 3h               # 重复报警的间隔时间
        receiver: mail                    # 全局报警组，这个参数是必选的，和下面报警组名要相同
        match: [labelname:labelvalue,labelname1,labelvalue1] # 通过标签去匹配这次告警是否符合这个路由节点, 必须全部匹配才可以告警。
        match_re: [labelname:regex]       # 通过正则表达是匹配标签, 意义同上

    receivers:
    - name: 'mail'                      # 报警组名
      email_configs:
      - to: 'sijiayong000@163.com'      # 发送给谁
      
     # 一个 inhibition 规则是在与另一组匹配器匹配的警报存在的条件下，
     # 使匹配一组匹配器的警报失效的规则。两个警报必须具有一组相同的标签。 
     # inhibit_rules 标记: 降低告警收敛，减少报警，发送关键报警
    inhibit_rules:
      # source_match: 匹配当前告警发生后其他告警抑制掉
      - source_match:
        severity: 'critical'  # severity: 指定告警级别
        
      target_match:   # target_match:抑制告警
        severity: 'warning'  # severity: 指定抑制告警级别
        
      equal: ['alertname', 'dev', 'instance'] # equal: 只有包含指定标签才可成立规则


      
## 参考
    
    http://t.zoukankan.com/winstom-p-11940570.html