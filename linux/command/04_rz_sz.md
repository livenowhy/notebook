# Mac上如何通过跳板机向服务器上上传大文件

## 配置mac 使 iTerm2 使用 rz、sz 远程上传或下载文件

    $ brew install lrzsz
    $ cd /usr/local/bin
    $ sudo wget https://github.com/aikuyun/iterm2-zmodem/blob/master/iterm2-recv-zmodem.sh
    $ sudo wget https://github.com/aikuyun/iterm2-zmodem/blob/master/iterm2-send-zmodem.sh
    $ sudo chmod 777 /usr/local/bin/iterm2-*


    设置Iterm2的Tirgger特性，profiles->default->editProfiles->Advanced中的Tirgger
    
    添加两条trigger，分别设置 Regular expression，Action，Parameters，Instant如下：
    
    1.第一条
    
        Regular expression: rz waiting to receive.\*\*B0100
        Action: Run Silent Coprocess
        Parameters: /usr/local/bin/iterm2-send-zmodem.sh
        Instant: checked
    
    2.第二条
    
        Regular expression: \*\*B00000000000000
        Action: Run Silent Coprocess
        Parameters: /usr/local/bin/iterm2-recv-zmodem.sh
        Instant: checked