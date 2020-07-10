# celery 详解

## celery 的装饰函数 task

    @task()
    def xxx():
        pass

    task() 可以将任务装饰为异步
    参数:
    name: 可以显示指定任务的名字
    serializer: 指定序列化的方法
    bind: 一个bool值，设置是否绑定一个task的实例，如果绑定，task会作为参数传递到函数中，可以访问到task实例的所有属性