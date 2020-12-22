# Python 标准库中 time 和 datetime 的区别与联系

## datetime

    datetime 比 time 高级了不少, 可以理解为 datetime 基于 time 进行了封装, 提供了更多实用的函数。
    在datetime 模块中包含了几个类，具体关系如下:
    object
        timedelta     # 主要用于计算时间跨度
        tzinfo        # 时区相关
        time          # 只关注时间
        date          # 只关注日期
        datetime      # 同时有时间和日期
    名称比较绕口，在实际实用中，用得比较多的是 datetime.datetime 和 datetime.timedelta,
    另外两个 datetime.date 和 datetime.time 实际使用和 datetime.datetime 并无太大差别。
    下面主要讲讲 datetime.datetime 的使用。
    使用 datetime.datetime.now() 可以获得当前时刻的 datetime.datetime 实例。 
    对于一个 datetime.datetime 实例，主要会有以下属性及常用方法，看名称就能理解，应该没有太大问题：

    datetime.year
    datetime.month
    datetime.day
    datetime.hour
    datetime.minute
    datetime.second
    datetime.microsecond
    datetime.tzinfo
     
    datetime.date()   # 返回 date 对象
    datetime.time()   # 返回 time 对象
    datetime.replace(name=value) # 前面所述各项属性是 read-only 的，需要此方法才可更改
    datetime.timetuple() # 返回time.struct_time 对象
    dattime.strftime(format) # 按照 format 进行格式化输出
    
    除了实例本身具有的方法,类本身也提供了很多好用的方法:
    datetime.today()a  # 当前时间，localtime
    datetime.now([tz]) # 当前时间默认 localtime
    datetime.utcnow()  # UTC 时间
    datetime.fromtimestamp(timestamp[, tz]) # 由 Unix Timestamp 构建对象
    datetime.strptime(date_string, format)  # 给定时间格式解析字符串

    请注意，上面省略了很多和时区相关的函数，如需使用请查文档。对于日期的计算，使用timedelta也算是比较简单的：
    In [1]: import datetime
    In [2]: time_now = datetime.datetime.now()
    In [3]: time_now
    Out[3]: datetime.datetime(2014, 10, 27, 21, 46, 16, 657523)
    
    In [4]: delta1 = datetime.timedelta(hours=25)
    In [5]: print(time_now + delta1)
    2014-10-28 22:46:16.657523
    
    In [6]: print(time_now - delta1)
    2014-10-26 20:46:16.657523
    甚至两个 datetime 对象直接相减就能获得一个 timedelta 对象。
    如果有需要计算工作日的需求，可以使用 business_calendar这个库，不需要装其他依赖就可使用。
    datetime.timedelta