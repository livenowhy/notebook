
# 收集数据 配置 列表
scrape_configs:
- job_name: prometheus  # 必须配置, 自动附加的job labels, 必须唯一

  # 文件服务发现配置 列表
  file_sd_configs:
    - files:  # 从这些文件中提取目标
      - foo/*.slow.json
      - foo/*.slow.yml
      - single/file.yml
      refresh_interval: 10m  # 刷新文件的 时间间隔
    - files:
      - bar/*.yaml
  
 
  
  
  # 目标节点 重新打标签 的配置 列表.  重新标记是一个功能强大的工具，可以在抓取目标之前动态重写目标的标签集。 可以配置多个，按照先后顺序应用
  relabel_configs:
  - source_labels: [job, __meta_dns_name]   # 从现有的标签中选择源标签, 最后会被 替换， 保持， 丢弃
    regex:         (.*)some-[regex]  # 正则表达式, 将会提取source_labels中匹配的值
    target_label:  job   # 在替换动作中将结果值写入的标签.
    replacement:   foo-${1}  # 如果正则表达匹配, 那么替换值. 可以使用正则表达中的 捕获组
    # action defaults to 'replace'
  - source_labels: [abc]  # 将abc标签的内容复制到cde标签中
    target_label:  cde
  - replacement:   static
    target_label:  abc
  - regex:
    replacement:   static
    target_label:  abc
  
  bearer_token_file: valid_token_file  # 可选的, bearer token 文件的信息
  
  

  
  
  # DNS 服务发现 配置列表
  dns_sd_configs:
  - refresh_interval: 15s
    names:  # 要查询的DNS域名列表
    - first.dns.address.domain.com
    - second.dns.address.domain.com
  - names:
    - first.dns.address.domain.com
    # refresh_interval defaults to 30s.
  
  
  # 目标节点 重新打标签 的配置 列表
  relabel_configs:
  - source_labels: [job]
    regex:         (.*)some-[regex]
    action:        drop
  - source_labels: [__address__]
    modulus:       8
    target_label:  __tmp_hash
    action:        hashmod
  - source_labels: [__tmp_hash]
    regex:         1
    action:        keep
  - action:        labelmap
    regex:         1
  - action:        labeldrop
    regex:         d
  - action:        labelkeep
    regex:         k
  
  
  # metric 重新打标签的 配置列表
  metric_relabel_configs:
  - source_labels: [__name__]
    regex:         expensive_metric.*
    action:        drop
  
  
- job_name: service-y
  
  # consul 服务发现 配置列表
  consul_sd_configs:
  - server: 'localhost:1234'  # consul API 地址
    token: mysecret
    services: ['nginx', 'cache', 'mysql']  # 被检索目标的 服务 列表. 如果不定义那么 所有 服务 都会被 收集
    scheme: https
    tls_config:
      ca_file: valid_ca_file
      cert_file: valid_cert_file
      key_file:  valid_key_file
      insecure_skip_verify: false
  
  relabel_configs:
  - source_labels: [__meta_sd_consul_tags]
    separator:     ','
    regex:         label:([^=]+)=([^,]+)
    target_label:  ${1}
    replacement:   ${2}
 
  
