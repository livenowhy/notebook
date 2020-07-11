# scrapy

## scrapy 命令

  `1` 创建项目 redspider

    $ scrapy startproject redspider

  `2` 运行 redspider 蜘蛛

    $ scrapy crawl redspider


## 文件启动

    from scrapy import cmdline
    cmdline.execute('scrapy crawl weixinspider'.split())


## 各浏览器的User-Agent

    http://www.useragentstring.com/index.php?id=248

