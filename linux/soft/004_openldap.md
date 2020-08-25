# centos7搭建LDAP服务器
## 环境准备：关闭selinux和firewall

## 安装

  `1` 安装LDAP服务器和客户端
    
    $ yum install -y openldap openldap-clients openldap-servers

  `2` 设置 DB Cache
    
    复制一个默认配置到指定目录下,并授权,这一步一定要做,然后再启动服务,不然生产密码时会报错
    $ cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
    
    授权给ldap用户,此用户yum安装时便会自动创建
    $ chown -R ldap:ldap /var/lib/ldap/
    
  `3` 启动 OpenLDAP, 并设置为开机启动 (先启动服务,配置后面再进行修改)
    
    $ systemctl start slapd.service
    $ systemctl enable slapd.service
    
    
## 配置 ldap
  
  `1` 生成管理员密码,记录下这个密码,后面需要用到
    
    $ slappasswd -s 123456
    {SSHA}aQvapeffbnE6jS2qzOsCwONSP3cupUog
    
  `2` 新增修改密码文件, ldif为后缀, 文件名随意, 不要在/etc/openldap/slapd.d/目录下创建类似文件
  
    生成的文件为需要通过命令去动态修改 ldap 现有配置,如下,我在家目录下,创建文件
    $ vim changepwd.ldif
    dn: olcDatabase={0}config,cn=config
    changetype: modify
    add: olcRootPW
    olcRootPW: {SSHA}aQvapeffbnE6jS2qzOsCwONSP3cupUog
    
    # 这里解释一下这个文件的内容：
    # 第一行执行配置文件，这里就表示指定为 cn=config/olcDatabase={0}config 文件。你到/etc/openldap/slapd.d/目录下就能找到此文件
    # 第二行 changetype 指定类型为修改
    # 第三行 add 表示添加 olcRootPW 配置项
    # 第四行指定 olcRootPW 配置项的值
    # 在执行下面的命令前，你可以先查看原本的olcDatabase={0}config文件，里面是没有olcRootPW这个项的，执行命令后，你再看就会新增了olcRootPW项，而且内容是我们文件中指定的值加密后的字符串
    # 执行命令，修改ldap配置，通过-f执行文件
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f changepwd.ldif
    $ ldapmodify -Y EXTERNAL -H ldapi:/// -f changepwd.ldif
    
    执行修改命令后,有如下输出则为正常:
    SASL/EXTERNAL authentication started
    SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
    SASL SSF: 0
    modifying entry "olcDatabase={0}config,cn=config"
    
    查看 olcDatabase={0}config 内容,新增了一个 olcRootPW 项:
    $ cat /etc/openldap/slapd.d/cn=config/olcDatabase\=\{0\}config.ldif
    上面就是一个完整的修改配置的过程, 切记不能直接修改 /etc/openldap/slapd.d/ 目录下的配置。
    
  `3` 导入模板

    # 我们需要向 LDAP 中导入一些基本的 Schema。这些 Schema 文件位于 /etc/openldap/schema/ 目录中，schema控制着条目拥有哪些对象类和属性，可以自行选择需要的进行导入，
    # 依次执行下面的命令，导入基础的一些配置,我这里将所有的都导入一下，其中core.ldif是默认已经加载了的，不用导入
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/collective.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/duaconf.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/misc.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/ppolicy.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/corba.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/dyngroup.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/openldap.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/java.ldif
    $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/pmi.ldif
    
    # $ ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/core.ldif
   
  `4` 修改域名
  
    # 新增 changedomain.ldif, 这里我自定义的域名为 livenowhy.com，管理员用户账号为 admin。
    # 如果要修改, 则修改文件中相应的 dc=livenowhy,dc=com为自己的域名
    
    $ vim changedomain_01.ldif
    dn: olcDatabase={1}monitor,cn=config
    changetype: modify
    replace: olcAccess
    olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" read by dn.base="cn=admin,dc=livenowhy,dc=com" read by * none
    
    $ vim changedomain_02.ldif
    dn: olcDatabase={2}hdb,cn=config
    changetype: modify
    replace: olcSuffix
    olcSuffix: dc=livenowhy,dc=com
    
    $ vim changedomain_03.ldif
    dn: olcDatabase={2}hdb,cn=config
    changetype: modify
    replace: olcRootDN
    olcRootDN: cn=admin,dc=livenowhy,dc=com
     
    $ vim changedomain_04.ldif
    dn: olcDatabase={2}hdb,cn=config
    changetype: modify
    replace: olcRootPW
    olcRootPW: {SSHA}aQvapeffbnE6jS2qzOsCwONSP3cupUog
    
    $ vim changedomain_05.ldif
    dn: olcDatabase={2}hdb,cn=config
    changetype: modify
    add: olcAccess
    olcAccess: {0}to attrs=userPassword,shadowLastChange by
      dn="cn=admin,dc=livenowhy,dc=com" write by anonymous auth by self write by * none
    olcAccess: {1}to dn.base="" by * read
    olcAccess: {2}to * by dn="cn=admin,dc=livenowhy,dc=com" write by * read

    # 执行命令, 修改配置, 以上注意 olcAccess 该换行时要换行
    $ ldapmodify -Y EXTERNAL -H ldapi:/// -f changedomain_01.ldif
    $ ldapmodify -Y EXTERNAL -H ldapi:/// -f changedomain_02.ldif
    $ ldapmodify -Y EXTERNAL -H ldapi:/// -f changedomain_03.ldif
    $ ldapmodify -Y EXTERNAL -H ldapi:/// -f changedomain_04.ldif
    $ ldapadd -Q -Y EXTERNAL -H ldapi:/// -f changedomain_05.ldif
    
  `5` 启用 memberof 功能
    
    a、新增add-memberof.ldif, #开启memberof支持并新增用户支持memberof配置
    $ vim add-memberof.ldif
    dn: cn=module{0},cn=config
    cn: modulle{0}
    objectClass: olcModuleList
    objectclass: top
    olcModuleload: memberof.la
    olcModulePath: /usr/lib64/openldap
    
    dn: olcOverlay={0}memberof,olcDatabase={2}hdb,cn=config
    objectClass: olcConfig
    objectClass: olcMemberOf
    objectClass: olcOverlayConfig
    objectClass: top
    olcOverlay: memberof
    olcMemberOfDangling: ignore
    olcMemberOfRefInt: TRUE
    olcMemberOfGroupOC: groupOfUniqueNames
    olcMemberOfMemberAD: uniqueMember
    olcMemberOfMemberOfAD: memberOf
    
    b、新增 refint1.ldif 文件
    $ vim refint1.ldif
    dn: cn=module{0},cn=config
    add: olcmoduleload
    olcmoduleload: refint
    
    c、新增 refint2.ldif 文件
    $ vim refint2.ldif
    dn: olcOverlay=refint,olcDatabase={2}hdb,cn=config
    objectClass: olcConfig
    objectClass: olcOverlayConfig
    objectClass: olcRefintConfig
    objectClass: top
    olcOverlay: refint
    olcRefintAttribute: memberof uniqueMember  manager owner
    
    # 依次执行下面命令,加载配置,顺序不能错:
    $ ldapadd -Q -Y EXTERNAL -H ldapi:/// -f add-memberof.ldif
    $ ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f refint1.ldif
    $ ldapadd -Q -Y EXTERNAL -H ldapi:/// -f refint2.ldif
    $ systemctl restart slapd.service
  
    到此,配置修改完了,在上述基础上,我们来创建一个叫做 livenowhy company 的组织,
    并在其下创建一个 admin 的组织角色(该组织角色内的用户具有管理整个 LDAP 的权限)和 People 和 Group 两个组织单元:  
    # 新增配置文件
    $ vim base_01.ldif
    dn: dc=livenowhy,dc=com
    objectClass: top
    objectClass: dcObject
    objectClass: organization
    o: livenowhy Company
    dc: livenowhy
    
    $ vim base_02.ldif
    dn: cn=admin,dc=livenowhy,dc=com
    objectClass: organizationalRole
    cn: admin
    
    $ vim base_03.ldif
    dn: ou=People,dc=livenowhy,dc=com
    objectClass: organizationalUnit
    ou: People
    
    $ vim base_04.ldif
    dn: ou=Group,dc=livenowhy,dc=com
    objectClass: organizationalRole
    cn: Group
    
    # 执行命令，添加配置, 这里要注意修改域名为自己配置的域名，然后需要输入上面我们生成的密码
    
    $ ldapadd -x -D cn=admin,dc=livenowhy,dc=com -W -f base_01.ldif
    $ ldapadd -x -D cn=admin,dc=livenowhy,dc=com -W -f base_02.ldif
    $ ldapadd -x -D cn=admin,dc=livenowhy,dc=com -W -f base_03.ldif
    $ ldapadd -x -D cn=admin,dc=livenowhy,dc=com -W -f base_04.ldif
    通过以上的所有步骤,我们就设置好了一个 LDAP 目录树:
    其中基准 dc=livenowhy,dc=com 是该树的根节点，
    其下有一个管理域 cn=admin,dc=livenowhy,dc=com 和两个组织单元 ou=People,dc=livenowhy,dc=com 及 ou=Group,dc=livenowhy,dc=com。
    
    $ slaptest -u
    测试配置文件, 末尾显示 configfile testing successed 说明成功
    

## 安装 phpldapadmin
    
  `1` 安装
  
    $ yum install -y phpldapadmin
    
  `2` 修改配置文件 phpldapadmin.conf
    
    $ vim /etc/httpd/conf.d/phpldapadmin.conf
    
    Require all granted   # 取消注释,或者添加
   
    # 修改apache的phpldapadmin配置文件
    # 修改如下内容，放开外网访问，这里只改了2.4版本的配置，因为centos7 默认安装的apache为2.4版本。所以只需要改2.4版本的配置就可以了
    # 如果不知道自己apache版本，执行 rpm -qa|grep httpd 查看apache版本
    <Directory /usr/share/phpldapadmin/htdocs>
      <IfModule mod_authz_core.c>
        # Apache 2.4
        Require all granted
      </IfModule>
      <IfModule !mod_authz_core.c>
        # Apache 2.2
        Order Deny,Allow
        Deny from all
        Allow from 127.0.0.1
        Allow from ::1
      </IfModule>
    </Directory>
    
  `3` 修改配置用DN登录ldap
  
    $ vim /etc/phpldapadmin/config.php
    # 398 行, 默认是使用uid进行登录, 我这里改为cn, 也就是用户名
    $servers->setValue('login','attr','cn');
    
    # 460 行, 关闭匿名登录, 否则任何人都可以直接匿名登录查看所有人的信息
    $servers->setValue('login','anon_bind',false);
     
    # 519 行,设置用户属性的唯一性,这里我将 cn,sn 加上了, 以确保用户名的唯一性
    $servers->setValue('unique','attrs',array('mail','uid','uidNumber','cn','sn'));
  
  `4` 修改默认端口
  
    $ vim /etc/httpd/conf/httpd.conf
    Listen 8081  # 如果 80 端口可用不需要修改
       
  `5` 启动服务, 测试
    
    $ systemctl start httpd.service
    $ systemctl enable httpd.service
    $ curl http://127.0.0.1:8081/ldapadmin
    $ curl http://core.livenowhy.com:8081/ldapadmin
 
  `6` 登录 phpldapadmin 界面
      
    用户名: admin, 密码: 123456
    参考: https://blog.csdn.net/weixin_41004350/article/details/89521170
    
    
### 异常处理

`1` slapd main: TLS init def ctx failed: -1; Failed to start OpenLDAP Server Daemon.
    
    通过命令检测过程: 
    $ slapd -d 1
    日志输出 ... ...
    
    重新创建证书,路径不存在则手动创建:
    $ mkdir -p /etc/openldap/certs
    $ bash /usr/libexec/openldap/create-certdb.sh
    $ bash /usr/libexec/openldap/generate-server-cert.sh
    
    重装:
    $ yum reinstall openldap openldap-servers openldap-clients
    
    
### 添加用户
    
    $ yum -y install migrationtools