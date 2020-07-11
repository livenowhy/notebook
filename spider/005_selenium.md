# selenium
 
 CentOS7下Chrome以及chromedriver的安装配置

`1` 在CentOS7中安装最新版本的Chrome浏览器

    yum install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    完成后在Applications中的Internet中可以找到谷歌浏览器

`2` chromedriver 下载安装(注意和Chrome版本相对应)

    https://chromedriver.storage.googleapis.com/index.html
    chromedriver和chrome的配套关系在下载目录的ntoes.txt中查看。
    下载完成后，解压文件，然后把它放到/usr/bin/下就可以了。


### yum 安装依赖

    yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    yum install -y Xvfb
    yum install -y libXfont
    yum install -y xorg-x11-fonts*
    yum install -y libgconf
    yum install -y GConf2
    yum install -y chromedriver chromium xorg-x11-server-Xvfb


### pip 安装

    pip install pyvirtualdisplay
    pip install selenium