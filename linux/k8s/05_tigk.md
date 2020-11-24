# TIGK技术栈
# 一、监控组件kapacitor初识



    TIGK 技术栈监控方案:
    TIGK 技术栈是一个开源的监控方案，其实本身技术栈为TICK 即 Telegraf, InfluxDB, Chronograf, Kapacitor, 但是由于Chronograf没有Grafana扩展性和易用性强，暂时使用了Grafana作为替代方案
    
TIGK技术栈包括
InfuluxDB go语言开发的时序数据库 时序数据库相比传统关系型数据库更关注数据的实时性和并发插入时的承受能力 开放有restfulAPI

Telegraf 同样是go语言开发的在目标机器上的agent采集工具，作为服务而言它很轻量级，并且扩展性也强，支持在linux系统下使用脚本对应用，容器等进行监控，监控采集的数据会发送给influxDB

Grafana 可视化的监控展示服务，提供包括折线图，饼图，仪表盘等多种监控数据可视化UI，支持多种不同的时序数据库数据源，Grafana对每种数据源提供不同的查询方法，而且能很好的支持每种数据源的特性。

Kapacitor TIGK技术栈的告警服务，用户通过tickScript脚本来对时序数据库当中的数据进行过滤，筛选，批处理等进行告警，告警信息可以通过日志保存在本地，或回插到influxdb，还可以直接在告警产生后发起http请求到指定地址，kapacitor支持数据流（stream）和批处理（batch）数据

关于前三个服务不准备写博客进行讲解，关于influxdb，telegraf，grafana网上的资料很多，但是kapacitor至今没能找到一个能让我满意的中文文档，所以当一次官方文档的搬运工，顺便说说自己对kapacitor的理解，在阅读此文档之前，默认读者已经了解了influxdb和telegraf

kapacitor是一个脚本定义告警规则服务，与influxdb强相关，安装kapacitor后通过配置kapacitor.conf文件来配置和influxdb连接（通常是与influxdb开放的本地端口8086连接）

安装：

wget https://dl.influxdata.com/kapacitor/releases/kapacitor-1.5.1.x86_64.rpm
1
启停服务：

service kapacitor start
service kapacitor stop

如果influxdb安装在本地且开启了8086端口，则不需要进行任何配置，如果influxdb安装在其它机器，则需要配置kapacitor连接influxdb的api

vi /etc/kapacitor/kapacitor.conf
1
kapacitor常用命令

kapacitor list tasks --显示所有当前kapacitor加载的脚本
kapacitor define {{ taskName }} -tick {{ tickScriptName }} -dbrp {{ dbrp }} -type {{ scriptType }} --安装脚本到kapacitor
kapacitor enable {{ taskName }} --脚本监控开启
kapacitor disable {{ taskName }} --脚本监控关闭
kapacitor show {{ taskName }} --显示某一个脚本的执行状态
kapacitor record {{recordType}} -task {{ taskName }} -duration {{ duration }} --记录某一时间段内某脚本运行状态（测试用）
kapacitor replay kapacitor replay -recording {{ rid }} -task {{ taskName }} --重复执行测试结果

比如以下这个脚本：

vi task01.tick
1
var data = stream
|from()
.measurement('cpu')
|alert()
.info(lambda: "usage_idle"<=20)
.post('http://192.168.199.215:9001')
1
2
3
4
5
6
此脚本作用为，在抓取到cpu表中cpu空闲率低于百分之20时即产生告警，
首先需要使用kapacitor define安装

kapacitor define task01 -tick task01.tick -dbrp "monitor_db.autogen" -type "stream"
1
然后使用 kapacitor record执行脚本采集

kapacitor record stream -task task01 -duration 10s
1
此命令会阻塞10秒，十秒以后系统会返回一个rid，通过此rid可以使用命令

kapacitor list recordings $rid
1
来查看脚本执行状态，通常如果size那一栏不为空，则说明脚本有数据流入，则当前脚本是有效的
如果脚本当中有触发告警，可以到/vars/log/kapacitor.log或/tmp/alert.log当中查看告警触发结果

确认告警脚本无误后，使用enable则可开启当前脚本的监控

kapacitor enable task01


https://blog.csdn.net/liuajiehe1234567/article/details/81990461


# 云监控对接Grafana
# https://help.aliyun.com/document_detail/109434.html?spm=a2c4g.11186623.6.571.fd891b89Oj0G08