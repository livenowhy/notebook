# Python 的 hasattr()、getattr()、setattr() 函数使用方法详解

## hasattr(object, name)

    判断一个对象里面是否有 name 属性或者 name 方法，返回BOOL值，有name特性返回True， 否则返回False。
    需要注意的是 name 要用括号括起来


## getattr(object, name[,default])

    获取对象 object 的属性或者方法，如果存在打印出来，如果不存在，打印出默认值，默认值可选。
    需要注意的是，如果是返回的对象的方法，返回的是方法的内存地址，如果需要运行这个方法，可以在后面添加一对括号。

## setattr(object, name, values)

    给对象的属性赋值，若属性不存在，先创建再赋值


# python __getattr__和__setattr__

    __getattr__：当使用点号获取实例属性时，如果属性不存在就自动调用__getattr__方法
    __setattr__：当设置类实例属性时自动调用，如j.name=5 就会调用__setattr__方法

self.[name]=5因为这个类是从dict继承来的，是dict的子类所以 self[attr]=value 相当于调用dict的下标方法与 a={} ; a[attr]=value意思一样。