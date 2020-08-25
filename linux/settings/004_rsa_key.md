# linux下生成https的crt和key证书

    x509证书一般会用到三类文: key, csr, crt
    key 是私用密钥 openssl 格,通常是 rsa 算法。
    csr 是证书请求文件,用于申请证书. 在制作 csr 文件的时,必须使用自己的私钥来签署申,还可以设定一个密钥.
    crt 是 CA 认证后的证书文,(windows下面的，其实是crt), 签署人用自己的key给你签署的凭证.

## 一、key的生成

    $ openssl genrsa -des3 -out server.key 2048
    这样是生成 rsa 私钥, des3 算法, openssl 格式,2048 位强度。
    server.key 是密钥文件名,为了生成这样的密钥,需要一个至少四位的密码. 
    
    可以通过以下方法生成没有密码的key:
    $ openssl rsa -in server.key -out server.key
    server.key 就是没有密码的版本了
    
## 二、生成 CA 的 crt

    $ openssl req -new -x509 -key server.key -out ca.crt -days 3650
    生成的 ca.crt 文件是用来签署下面的 server.csr 文件
    
## 三、csr的生成方法

    $ openssl req -new -key server.key -out server.csr
    需要依次输入国家,地区,组织,email.
    最重要的是有一个common name,可以写你的名字或者域名。
    如果为了https申请，这个必须和域名吻合，否则会引发浏览器警报。生成的csr文件交给CA签名后形成服务端自己的证书。 

    

## 四、crt生成方法

    CSR文件必须有CA的签名才可形成证书，可将此文件发送到verisign等地方由它验证，要交一大笔钱，何不自己做CA呢。
    $ openssl x509 -req -days 3650 -in server.csr -CA ca.crt -CAkey server.key -CAcreateserial -out server.crt
    输入 key 的密钥后,完成证书生成. 
    -CA 选项指明用于被签名的 csr 证书,
    -CAkey 选项指明用于签名的密钥
    -CAserial 指明序列号文件
    -CAcreateserial 指明文件不存在时自动生成。
    
    最后生成了私用密钥：server.key 和自己认证的SSL证书: server.crt

    证书合并: cat server.key server.crt > server.pem


## 使用openssl生成公私钥对

  `1` 生成.pem格式的私钥

    openssl genrsa -out private_key.pem 2048

  `2` 通过私钥生成.pem格式的公钥 （生成出来的格式是pkcs#1.5）

    openssl rsa -in private_key.pem -pubout -out public_key.pem

  `3` PKCS1私钥转换为PKCS8(该格式一般java调用)

    openssl pkcs8 -topk8 -inform PEM -in private_key.pem -outform pem -nocrypt -out pkcs8.pem

  `4` PKCS8格式私钥转换为PKCS1（传统私钥格式）

    openssl pkcs8 -in pkcs8.pem -nocrypy -out private_key.pem

## ssh-keygen 生成公私钥对

  `1` 生成私钥

    ssh-keygen -t rsa -b 2048 -C "youremail@example.com"
    最后 -C 参数是给这把钥匙的公钥添加一个comment;
    -t指定算法, -b指定长度。
    这种生成方法会让你输入一个密码,这个密码会对生成的private_key进行加密。

    如果你想使用这把钥匙进行加解密签名转成上面格式的钥匙的话。
    需要使用：
    openssl rsa -in <Encrypted key filename>  -out < desired output file name>
    可以去掉密码，得到私钥。
    然后再使用这把私钥生成一个公钥，向上面一样操作就可以了。
    直接使用生成pair的公钥应该是不行的，格式不一样并不是pkcs#1.5。