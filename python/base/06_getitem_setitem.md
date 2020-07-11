#### python 类的特殊方法: __getitem__ 、 __setitem__ 、 _delitem__的使用

    class MyDict(object):

        def __init__(self):
            self.value = {}

        def __setitem__(self, item, value):
            self.value[item] = value

        def __getitem__(self, item):
            return self.value[item]

        def __delitem__(self, item):
            del self.value[item]

        def __str__(self):
            return str(self.value)


    if __name__ == '__main__':
        md = MyDict()

        md['a'] = 'a'
        md['b'] = 'b'
        md['c'] = 'c'
        print md['a']

    del md['a']

    print md



#########

#
# def super(cls, inst):
#     mro = inst.__class__.mro()
#     return mro[mro.index(cls) + 1]

# 两个参数 cls 和 inst 分别做了两件事
# 1. inst 负责生成 MRO 的 list
# 2. 通过 cls 定位当前 MRO 中的 index, 并返回 mro[index + 1]
# 这两件事才是 super 的实质，一定要记住！
# MRO 全称 Method Resolution Order，它代表了类继承的顺序。后面详细说


class Root(object):
    def __init__(self):
        print 'this is Root'


    def do(self):
        print 'Root do'


class B(Root):
    def __init__(self):
        print 'enter B'
        super(B, self).__init__()
        print 'leave B'

    def do(self):
        print 'B do'


class C(Root):
    def __init__(self):
        print 'enter C'
        super(C, self).__init__()
        print 'leave C'

    def do(self):
        print 'C do'


class D(B, C):
    pass


class F(B, C):
    def __init__(self):
        print 'enter F'
        super(F, self).__init__()
        print 'leave F'

    def do(self):
        print 'F do'


d = D()

print d.__class__.__mro__

print 'sssssss'
f = F()

print f.__class__.__mro__
f.do()

# enter B
# enter C
# this is Root
# leave C
# leave B
# (<class '__main__.D'>, <class '__main__.B'>, <class '__main__.C'>, <class '__main__.Root'>, <type 'object'>)

# 知道了 super 和父类其实没有实质关联之后，
# 我们就不难理解为什么 enter B 下一句是 enter C 而不是 this is Root
# (如果认为 super 代表"调用父类的方法"，会想当然的认为下一句应该是this is Root)。
# 流程如下，在 B 的 __init__ 函数中: super(B, self).__init__()

# 首先，我们获取 self.__class__.__mro__，注意这里的 self 是 D 的 instance 而不是 B 的
# (<class '__main__.D'>, <class '__main__.B'>, <class '__main__.C'>, <class '__main__.Root'>, <type 'object'>)


# 然后，通过 B 来定位 MRO 中的 index，并找到下一个。显然 B 的下一个是 C。
# 于是，我们调用 C 的 __init__，打出 enter C。
# 顺便说一句为什么 B 的 __init__ 会被调用:
# 因为 D 没有定义 __init__，所以会在 MRO 中找下一个类，去查看它有没有定义 __init__，也就是去调用 B 的 __init__。

# 其实这一切逻辑还是很清晰的，关键是理解 super 到底做了什么。
# 于是，MRO 中类的顺序到底是怎么排的呢？Python’s super() considered super!中已经有很好的解释，我翻译一下:
# 在 MRO 中，基类永远出现在派生类后面，如果有多个基类，基类的相对顺序保持不变。

# 最后的最后，提醒大家.
# 什么 super 啊，MRO 啊，都是针对 new-style class。
# 如果不是 new-style class，就老老实实用父类的类名去调用函数吧。


# 在 MRO 中，基类永远出现在派生类后面，如果有多个基类，基类的相对顺序保持不变。
# 这个原则包括两点:
# 基类永远在派生类后面
# 类定义时的继承顺序影响相对顺序.


# 参考资料 https://laike9m.com/blog/li-jie-python-super,70/

# super() 函数是用于调用父类(超类)的一个方法。
# super 是用来解决多重继承问题的，直接用类名调用父类方法在使用单继承的时候没问题，
# 但是如果使用多继承，会涉及到查找顺序（MRO）、重复调用（钻石继承）等种种问题。
# MRO 就是类的方法解析顺序表, 其实也就是继承父类方法时的顺序表。
