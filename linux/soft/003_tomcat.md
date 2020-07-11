#### redhat上安装tomcat

    三、安装JDK 
    安装tomcat的前提是安装JDK，所以第一步先安装JDK。 

    1、 上传文件。 

    在linux中建个文件夹，然后把下载下来的JDK传到该文件夹中，并查看权限。我们可以看到我对这个文件夹的权限是rw-,也就是读写权限，没有执行权限。如下图： 


    2、 赋权限。 

    用Chmod 755 JDK来给当前用户赋可以执行该文件权限。 

    Linxu中 r=4，w=2, x=1所以755的含义就是rwx r-x r-x。 

    3、 执行 

    4、 安装。rpm –ivh jdk.rmp. 

    这个是Red hat linux的安装当前目录下所有rpm软件包的命令，可能其它linux也可以用这个命令。安装完毕后，JDK默认安装在/usr/java/jdk中。 
    5、设置环境变量 
    在/etc/profile中加入以下内容： 
    JAVA_HOME=/usr/java/jdk 
    CLASSPATH=$PATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib 
    PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin 
    export PATH CLASSPATH JAVA_HOME 
    6、 reboot redhat. 
    重启后在终端执行 java –version，若出现JDK版本则表明安装JDK成功。 

    四、安装tomcat 
    1、上传tomcat 
    把下载好的tomcat上传到/usr/local/目录下面 
    2、解压 
    tar –zxvf apache-tomcat.taz.gz 
    3、移动该文件夹并重命名tomcat 
    Mv apache-tomcat /usr/local/tomcat 
    4、启动tomcat 
    ./startup.sh 
    1、 当问tomcat页面 
    http://localhost:8080 

    如果其他机器访问不了，则把linux中的8080端口开启，或者关闭防火墙。 
    1、 开启8080端口。 
    在/ect/sysconfig下编写iptables文件 
    加入一行 
    -A RH-Firewall-1-INPUT –m state NEW –m tcp –p tcp –dport 8080 –j ACCEPT 
    2、关闭防火墙 
    （1）关闭立即生效，重启后又开启 
    service iptables stop 
    同理：立即开启 service iptable start 
    (2)重启后生效 
    chkconfig iptables off 
    同理：重启后开启 chkconfig service on