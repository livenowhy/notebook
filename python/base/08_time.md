## time
    
    在 Python 文档里，time 是归类在 Generic Operating System Services 中，换句话说， 它提供的功能是更加接近于操作系统层面的。
    通读文档可知，time 模块是围绕着 Unix Timestamp 进行的。
    
    该模块主要包括一个类 struct_time，另外其他几个函数及相关常量。 
    需要注意的是在该模块中的大多数函数是调用了所在平台 C library的同名函数， 所以要特别注意有些函数是平台相关的，可能会在不同的平台有不同的效果。
    另外一点是，由于是基于Unix Timestamp，所以其所能表述的日期范围被限定在 1970 - 2038 之间，如果你写的代码需要处理在前面所述范围之外的日期，那可能需要考虑使用datetime模块更好。
    

import time
 
time.time()
1414332433.345712
timestamp = time.time()
 
time.gmtime(timestamp)
time.struct_time(tm_year=2014, tm_mon=10, tm_mday=26, tm_hour=14, tm_min=7, tm_sec=13, tm_wday=6, tm_yday=299, tm_isdst=0)
 
time.localtime(timestamp)
time.struct_time(tm_year=2014, tm_mon=10, tm_mday=26, tm_hour=22, tm_min=7, tm_sec=13, tm_wday=6, tm_yday=299, tm_isdst=0)
struct_time = time.localtime(timestamp)
 
In [7]: time.ctime(timestamp)
Out[7]: 'Sun Oct 26 22:07:13 2014'
 
In [8]: time.asctime(struct_time)
Out[8]: 'Sun Oct 26 22:07:13 2014'
 
In [9]: time.mktime(struct_time)
Out[9]: 1414332433.0
 
In [10]: time.strftime("%a, %d %b %Y %H:%M:%S +0000", struct_time)
Out[10]: 'Sun, 26 Oct 2014 22:07:13 +0000'
 
In [11]: time.strptime("30 Nov 00", "%d %b %y")
Out[11]: time.struct_time(tm_year=2000, tm_mon=11, tm_mday=30, tm_hour=0, tm_min=0, tm_sec=0, tm_wday=3, tm_yday=335, tm_isdst=-1)
问题不大，可能有时候需要注意一下使用的时区。
