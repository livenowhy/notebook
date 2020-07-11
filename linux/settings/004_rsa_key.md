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