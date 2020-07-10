# python django 模型内部类 meta 详细解释

## Django 模型类的 Meta 是一个内部类，它用于定义一些 Django 模型类的行为特性

### abstract

    这个属性是定义当前的模型类是不是一个抽象类。
    所谓抽象类是不会相应数据库表的。一般我们用它来归纳一些公共属性字段，然后继承它的子类能够继承这些字段。
    比方以下的代码中 Human 是一个抽象类。Employee 是一个继承了 Human 的子类，那么在执行 syncdb 命令时，不会生成Human表。
    可是会生成一个 Employee 表，它包括了 Human 中继承来的字段。以后假设再加入一个 Customer 模型类，它能够相同继承 Human 的公共属性：

    class Human(models.Model):
        name=models.CharField(max_length=100)
        GENDER_CHOICE=((u'M',u'Male'),(u'F',u'Female'),)
        gender=models.CharField(max_length=2,choices=GENDER_CHOICE,null=True)
        class Meta:
            abstract=True

    class Employee(Human):
        joint_date=models.DateField()

    class Customer(Human):
        first_name=models.CharField(max_length=100)
        birth_day=models.DateField()

### app_label

    app_label这个选项仅仅在一种情况下使用，就是你的模型类不在默认的应用程序包下的 models.py 文件里。
    这时候你须要指定你这个模型类是那个应用程序的。比方你在其它地方写了一个模型类，而这个模型类是属于 userapp 的，那么你这是须要指定为: app_label='userapp'

### db_table

    db_table是用于指定自己定义数据库表名的。
    Django有一套默认的依照一定规则生成数据模型相应的数据库表名。假设你想使用自己定义的表名。就通过这个属性指定，比方: table_name='user_table'


### db_tablespace

    有些数据库有数据库表空间，比方Oracle。你能够通过 db_tablespace 来指定这个模型相应的数据库表放在哪个数据库表空间。

### get_latest_by

    因为Django的管理方法中有个 lastest() 方法，就是得到近期一行记录。
    假设你的数据模型中有 DateField 或 DateTimeField 类型的字段。你能够通过这个选项来指定 lastest() 是依照哪个字段进行选取的。

### managed

    因为 Django 会自己主动依据模型类生成映射的数据库表。假设你不希望Django这么做。能够把managed的值设置为False。

### order_with_respect_to

    这个选项一般用于多对多的关系中，它指向一个关联对象。就是说关联对象找到这个对象后它是经过排序的。
    指定这个属性后你会得到一个get_XXX_order()和set_XXX_order（）的方法,通过它们你能够设置或者回去排序的对象。

### ordering

    这个字段是告诉Django模型对象返回的记录结果集是依照哪个字段排序的。比方以下的代码:

    ordering=['order_date'] # 按订单升序排列
    ordering=['-order_date'] # 按订单降序排列，-表示降序
    ordering=['?order_date'] # 随机排序。？表示随机

### permissions

    permissions主要是为了在Django Admin管理模块下使用的。假设你设置了这个属性能够让指定的方法权限描写叙述更清晰可读。


### unique_together

    unique_together这个选项用于: 当你须要通过两个字段保持唯一性时使用。
    比方如果你希望，一个Person的FirstName和LastName两者的组合必须是唯一的，那么须要这样设置：
    unique_together = (("first_name", "last_name"),)

### verbose_name

    verbose_name的意思非常easy。就是给你的模型类起一个更可读的名字：
    verbose_name = "pizza"
    verbose_name_plural
    这个选项是指定。模型的复数形式是什么。比方：

    verbose_name_plural = "stories"
    假设你不指定 Django 在型号名称加一后，自己主动’s’
    
### Django 的 order_by 查询集, 升序和降序
    
    Publisher.objects.order_by("state_province", "address")
    Publisher.objects.order_by("-name")     # 指定逆向排序，在前面加一个减号 - 前缀:

### django orm 比较运算

    不等于(exclude)
    __gt   大于

    __gte  大于等于

    __lt   小于

    __lte  小于等于


