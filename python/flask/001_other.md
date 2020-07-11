# flask 其他设置

## flashing 消息闪现

  好的应用和用户界面的重点是回馈。如果用户没有得到足够的反馈，他们可能最终会对您的应用产生不好的评价。
  Flask 提供了一个非常简单的方法来使用闪现系统向用户反馈信息。
  闪现系统使得在一个请求结束的时候记录一个信息，然后在且仅仅在下一个请求中访问这个数据。
  这通常配合一个布局模板实现
  
  [文档](http://docs.jinkan.org/docs/flask/patterns/flashing.html)
    
    其中 app.secret_key = 'secret_key-test' 必须要设置
  
  
## caching 缓存

  简单的本地缓存:
  
    import time
    from werkzeug.contrib.cache import SimpleCache
    
    cache = SimpleCache()
    
    def calculate_value():
        return time.time()
    
    def get_my_item(key):
        rv = cache.get(key=key)
        if rv is None:
            rv = calculate_value()
            cache.set(key=key, value=rv, timeout=5 * 60)
        return rv
        
  [文档](http://flask.pocoo.org/docs/0.10/patterns/caching/)
  
  也可以采用:
    
    from werkzeug.contrib.cache import MemcachedCache
    cache = MemcachedCache(['127.0.0.1:11211'])
    
    from werkzeug.contrib.cache import GAEMemcachedCaches
    cache = GAEMemcachedCache()
    
    
## errorpages 错误处理页面

    @app.errorhandler(404)
    def page_not_found(e):
        return 'page_not_found'
        # return render_template('404.html'), 404
        
  [文档](http://flask.pocoo.org/docs/0.12/patterns/errorpages/)
  

## favicon 网站图标

  `1` 应用在根目录, 简单实现
    
    app.add_url_rule('/favicon.ico',
                 redirect_to=url_for('static', filename='favicon.ico'))
                 
  `2` 使用 send_from_directory()
  
  如果想要保存额外的重定向请求，您也可以使用 send_from_directory() 函数写一个视图函数:
  
    import os
    from flask import send_from_directory
    
    @app.route('/favicon.ico')
    def favicon():
        return send_from_directory(os.path.join(app.root_path, 'static'),
                                   'favicon.ico', mimetype='image/vnd.microsoft.icon')
                                  
  我们可以不详细指定 mimetype , 浏览器将会自行猜测文件的类型。
  但是我们也可以指定它以便于避免额外的猜测, 因为这个 mimetype 总是固定的。

  以上的代码将会通过您的应用程序来提供图标文件的访问。
  然而，如果可能的话 配置您的网页服务器来提供访问服务会更好。请参考对应网页服务器的文档。

  [文档](http://docs.pythontab.com/flask/flask0.10/patterns/favicon.html)
  
## fileuploads 上传文件

  他基本是这样工作的:

  `1` 一个 <form> 标签被标记有 enctype=multipart/form-data, 并且在里面包含一个 <input type=file> 标签。
  `2` 服务端应用通过请求对象上的 files 字典访问文件。
  `3` 使用文件的 save() 方法将文件永久地保存在文件系统上的某处。


  [文档](http://docs.jinkan.org/docs/flask/patterns/fileuploads.html)
  
  
#### appfactories 应用程序的工厂函数

  自我感觉不太好用, 直接使用蓝图
  [文档](http://docs.pythontab.com/flask/flask0.10/patterns/appfactories.html)
  
## MongoKit 在 Flask 中使用 MongoKit

  现在使用文档型数据库来取代关系型数据库已越来越常见。
  本方案展示如何使用 MongoKit ,它是一个用于操作 MongoDB 的文档映射库。

  [文档](http://www.pythondoc.com/flask/patterns/mongokit.html)
  
## sqlite3 在 Flask 中使用 SQLite 3

  在 Flask 中, 在请求开始的时候用 before_request() 装饰器实现打开数据库连接的代码,
  然后在请求结束的时候用 before_request() 装饰器关闭数据库连接。在这个过程中需要配合 g 对象。
  
    @app.teardown_request
    def teardown_request(exception):
        if hasattr(g, 'db'):
            g.db.close()
  
  
  注解:请记住,teardown request 在请求结束时总会运行，即使 before-request 处理器运行失败或者从未运行过。
  我们需要确保数据库连接在关闭的时候在那里
  
  [文档](http://docs.jinkan.org/docs/flask/patterns/sqlite3.html)