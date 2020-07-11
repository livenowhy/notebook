## python 字符串操作

  `1` 去空格以及特殊符号
    
    s.strip()去除前后空格
    lstrip()   rstrip()      strip(',')

  `2` 将字符串中的大小写转换
    
    S.lower()               # 小写
    S.upper()               # 大写
    S.swapcase()            # 大小写互换
    S.capitalize()          # 首字母大写
    String.capwords(S)      # 模块中的方法,它把S用split()函数分开,然后用capitalize()把首字母变成大写,最后用join()合并到一起.

  `3` 翻转字符串
    
    s1 = 'abcdefg'
    s1 = s1[::-1]
    print s1

  `4` 连接字符串

    delimiter = ','
    mylist = ['Brazil', 'Russia', 'India', 'China']
    print delimiter.join(mylist)

  `5` 截取字符串

    str = '0123456789′
    print str[:]       # 截取字符串的全部字符
    print str[6:]      # 截取第七个字符到结尾(不会越界)
    print str[:-3]     # 截取从头开始到倒数第三个字符之前
    print str[2]       # 截取第三个字符
    print str[-1]      # 截取倒数第一个字符
    print str[::-1]    # 创造一个与原字符串顺序相反的字符串
    print str[-3:-1]   # 截取倒数第三位与倒数第一位之前的字符
    print str[-3:]     # 截取倒数第三位到结尾
    print str[:-5:-3]  # 逆序截取

  `6` 字符串在输出时的对齐

    s1 = '123456'
    s1.ljust(width,[fillchar])  # 输出width个字符，s1左对齐, 不足部分用fillchar填充(可选参数), 默认的为空格。 
    s1.rjust(width,[fillchar])   #右对齐 
    s1.center(width, [fillchar]) #中间对齐 
    s1.zfill(width)              #把S变成width长，并在右对齐，不足部分用0补足

  `7` 字符串中的搜索和替换 

    S.find(substr, [start, [end]]) 
    # 返回S中出现 substr 的第一个字母的标号，如果S中没有substr则返回-1。start和end作用就相当于在S[start:end]中搜索 

    S.index(substr, [start, [end]]) 
    # 与find()相同，只是在S中没有substr时，会返回一个运行时错误

    S.rfind(substr, [start, [end]]) 
    #返回S中最后出现的substr的第一个字母的标号，如果S中没有substr则返回-1，也就是说从右边算起的第一次出现的substr的首字母标号

    S.rindex(substr, [start, [end]])

    S.count(substr, [start, [end]]) #计算substr在S中出现的次数

    S.strip([chars]) 
    # 把S中前后chars中有的字符全部去掉，可以理解为把S前后chars替换为None

    S.lstrip([chars])

    S.rstrip([chars]) 

    S.expandtabs([tabsize]) 
    # 把S中的tab字符替换没空格，每个tab替换为tabsize个空格，默认是8个

  `8` 字符串的分割和组合

    S.split([sep, [maxsplit]]) 
    # 以sep为分隔符，把S分成一个list。maxsplit表示分割的次数。默认的分割符为空白字符

    S.rsplit([sep, [maxsplit]])

    S.splitlines([keepends])
    # 把S按照行分割符分为一个list，keepends是一个bool值，如果为真每行后而会保留行分割符。 

    S.join(seq) # 把 seq 代表的序列──字符串序列，用S连接起来


  `8` 字符串还有一对编码和解码的函数

    S.encode([encoding,[errors]]) 
    # 其中encoding可以有多种值，比如gb2312 gbk gb18030 bz2 zlib big5 bzse64等都支持。
    # errors默认值为"strict"，意思是UnicodeError。可能的值还有'ignore', 'replace', 'xmlcharrefreplace', 'backslashreplace' 和所有的通过codecs.register_error注册的值。

    S.decode([encoding,[errors]])

  `9` 字符串的测试、判断函数，这些函数返回的都是bool值 

    S.startswith(prefix[,start[,end]]) # 是否以prefix开头 

    S.endswith(suffix[,start[,end]])   # 以suffix结尾 

    S.isalnum() # 是否全是字母和数字，并至少有一个字符

    S.isalpha() # 是否全是字母，并至少有一个字符 

    S.isdigit() # 是否全是数字，并至少有一个字符 

    S.isspace() # 是否全是空白字符，并至少有一个字符 

    S.islower() # S中的字母是否全是小写 

    S.isupper() # S中的字母是否便是大写 

    S.istitle() # S是否是首字母大写的