# python 特性

## 一、assert 断言

    使用 assert 断言是学习 python 一个非常好的习惯, python assert 断言句语格式及用法很简单

    python assert 断言是声明其布尔值必须为真的判定,如果发生异常就说明表达示为假.
    可以理解 assert 断言语句为 raise-if-not, 用来测试表示式, 其返回值为假, 就会触发异常

    assert 的异常参数, 其实就是在断言表达式后添加字符串信息, 用来解释断言并更好的知道是哪里出了问题
    assert expression [, arguments]
    assert 表达式 [, 参数]

    try:
        assert 1==2, "1!=2"
    except AssertionError:
        print 'AssertionError error'
    except Exception:
        print "other error"

    assert 1==1

    
## 二、is 和 = 的区别

  `1` is 比较两个对象的 id 值是否相等,是否指向同一个内存地址
  `2` == 比较的是两个对象的内容是否相等,值是否相等
  `3` 小整数对象[-5,256]在全局解释器范围内被放入缓存供重复使用 (超过这个范围则会 分配不同的内存地址)
  `4` is 运算符比 == 效率高,在变量和None进行比较时，应该使用 is

  `5` 只有数值型和字符串型的情况下, a is b才为True (但是要符合总结3, 而且和解释器有关)
  `6` 当a和b是tuple, list, dict或set型时, a is b为False

    a = 1
    b = 1
    print a is b  # True 但是 ipython 命令行执结构在不同解释器情况下可能输出True或者False
    

## 三、python _(单下划线) 和 __(双下划线)

  `1` "_" 单下划线

    Python中不存在真正的私有方法。
    为了实现类似于c++中私有方法，可以在类的方法或属性前加一个"_"单下划线，意味着该方法或属性不应该去调用，它并不属于API。
    在使用property时，经常出现这个问题:
    class BaseForm(StrAndUnicode):
        def _get_errors(self):
            "Returns an ErrorDict for the data provided for the form"
            if self._errors is None:
                self.full_clean()
            return self._errors

        errors = property(_get_errors)
        上面的代码片段来自于django源码(django/forms/forms.py)

    这里的errors是一个属性，属于API的一部分，但是_get_errors是私有的，是不应该访问的，但可以通过errors来访问该错误结果。

  `2` "__"双下划线

    这个双下划线更会造成更多混乱, 但它并不是用来标识一个方法或属性是私有的，真正作用是用来避免子类覆盖其内容。
    让我们来看一个例子:
    class A(object):
        def __method(self):
            print "I'm a method in A"

        def method(self):
            self.__method()

    a = A()
    a.method()

    # 输出如下:
    # I'm a method in A

    # 我们给A添加一个子类，并重新实现一个__method：
    class B(A):
        def __method(self):
            print "I'm a method in B"

    b = B()
    b.method()
    # 现在，结果是这样的:
    # I'm a method in A

    # 就像我们看到的一样，B.method()不能调用B.__method的方法。
    # 实际上，它是"__"两个下划线的功能的正常显示。
    # 因此，在我们创建一个以"__"两个下划线开始的方法时，这意味着这个方法不能被重写，它只允许在该类的内部中使用。
    # 在Python中如是做的？很简单，它只是把方法重命名了，如下：
    a = A()
    a._A__method()  # never use this!! please!
    # 输出如下:
    # I'm a method in A
    # 如果你试图调用a.__method，它还是无法运行的，就如上面所说，只可以在类的内部调用__method。

    # "__xx__"前后各双下划线
    # 当你看到"__this__"的时，就知道不要调用它。为什么？因为它的意思是它是用于Python调用的，如下:

    # name = "igor"
    # name.__len__() 4
    # len(name) 4
    # number = 10
    # number.__add__(20) 30
    # number + 20 30
    # “__xx__”经常是操作符或本地函数调用的magic methods。在上面的例子中，提供了一种重写类的操作符的功能。
    # 在特殊的情况下，它只是python调用的hook。例如，__init__()函数是当对象被创建初始化时调用的;__new__()是用来创建实例。
    class CrazyNumber(object):
        def __init__(self, n):
            self.n = n

        def __add__(self, other):
            return self.n - other

        def __sub__(self, other):
            return self.n + other

        def __str__(self):
            return str(self.n)

    num = CrazyNumber(10)
    print num
    print num + 5
    print num - 4
    # 输出:
    # 10
    # 5
    # 14

    class Room(object):
        def __init__(self):
            self.people = []

        def add(self, person):
            self.people.append(person)

        def __len__(self):
            return len(self.people)

    room = Room()
    room.add('Igor')
    print len(room)

    # 结论
    # 使用_one_underline来表示该方法或属性是私有的，不属于API；
    # 当创建一个用于python调用或一些特殊情况时，使用__two_underline__；
    # 使用__just_to_underlines，来避免子类的重写！



    # 类的私有属性:
    # __private_attrs:
    # 两个下划线开头，表该改属性为私有，不能在类的外部被使用或直接访问。
    # 在类内部的方法中使用时: self.__private_attrs

    # 在类的内部，使用 def
    # 关键字可以为类定义一个方法，与一般函数定义不同，类方法必须包含参数 self，且为第一个参数

    # __private_method:
    # 两个下划线开头，声明该方法为私有方法，不能在类外部调用。在类内部调用
    # self.__private_method

## 四、lambda

    An anonymous inline function consisting of a single expression which is evaluated when the function is called.
    The syntax to create a lambda function is lambda [arguments]: expression
    lambda函数也叫匿名函数, 即函数没有具体的名称,而用def创建的方法是有名称的
    lambda允许用户快速定义单行函数

    lambda 只是一个表达式,函数体比 def 简单很多. lambda 的主体是一个表达式,而不是一个代码块.
    仅仅能在 lambda 表达式中封装有限的逻辑进去


    由于lambda只是一个表达式,它可以直接作为Python列表或Python字典的成员,比如: info = [lambda a: a**3, lambda b: b**3].
    这个地方没法用def语句直接代替,因为def是语句,不是表达式不能嵌套在里面,lambda表达式在":"后面只能有一个表达式。
    也就是说，在def中，用return可以返回的也可以在lambda后面，不能用return返回的也不能定义在lambda后面。
    因此，像if或for或print这样的语句就不能用于lambda中，lambda一般只用于定义简单的函数。

    # 用 lambda 表达式求n的阶乘.
    # n = 3
    # print reduce(lambda x, y: x*y, range(1, n+1))
    # 6


    a = lambda x: lambda y: x/y
    print a        # <function <lambda> at 0x102273c08>
    
    print a(2)     # <function <lambda> at 0x10227a0c8>
    
    print a(2)(1)  # 2

    def multipliers():
        return [lambda x:i * x for i in range(4)]

    print [m(2) for m in multipliers()] # out: [6, 6, 6, 6]
    因为Python中的迟绑定 (late binding) 机制, 即闭包中变量的值只有在内部函数被调用时才会进行查询。
    因此，在上面的代码中，每次multipliers()所返回的函数被调用时，都会在附近的作用域中查询变量i的值(而到那时，循环已经结束，所以变量i最后被赋予的值为3)


    # 默认参数
    def hock_multiplies():
        return [lambda x, i=i: i * x for i in range(5)]

    print [m(2) for m in hock_multiplies()]  # out: [0, 2, 4, 6, 8]

