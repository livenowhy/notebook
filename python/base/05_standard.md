# python 标准库

## 链接

### 内置函数

    https://docs.python.org/zh-cn/3.6/library/functions.html

### 内置常量

    True、False、None
    (完)

### 内置类型

#### 迭代器类型
  
  Python 支持在容器中进行迭代的概念。 这是通过使用两个单独方法来实现的；它们被用于允许用户自定义类对迭代的支持。
  
  容器对象要提供迭代支持，必须定义一个方法:

    container.__iter__()
    返回一个迭代器对象。
    该对象需要支持下文所述的迭代器协议。 如果容器支持不同的迭代类型，则可以提供额外的方法来专门地请求不同迭代类型的迭代器。

  迭代器对象自身需要支持以下两个方法，它们共同组成了 __迭代器协议__:

    iterator.__iter__()
    返回迭代器对象本身。 这是同时允许容器和迭代器配合 for 和 in 语句使用所必须的。

    iterator.__next__()
    从容器中返回下一项。 如果已经没有项可返回，则会引发 StopIteration 异常。

  Python 定义了几种迭代器对象以支持对一般和特定序列类型、字典和其他更特别的形式进行迭代。 除了迭代器协议的实现，特定类型的其他性质对迭代操作来说都不重要。

  一旦迭代器的 __next__() 方法引发了 StopIteration，它必须一直对后续调用引发同样的异常。 不遵循此行为特性的实现将无法正常使用。

#### 生成器类型

    https://docs.python.org/zh-cn/3.6/library/stdtypes.html#generator-types

#### 序列类型 — list, tuple, range
  
  有三种基本序列类型：list, tuple 和 range 对象。