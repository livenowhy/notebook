#  同一台机器下多个github账号应用不同的SSH配置

## 应用场景

  使用不同的github账号,提交代码(一个公司账号, 一个个人账号)

##  创建不同的公钥
   
  分别为公司账号和个人账号创建一个公钥,假定两个公钥创建完后为:

	~/.ssh/id_rsa
	~/.ssh/livenowhy
  
  按照如下方式添加这两个公钥

	$ ssh-add ~/.ssh/id_rsa
	$ ssh-add ~/.ssh/livenowhy
  
  最后,你可以使用如下命令检查已保存的公钥：

    $ ssh-add -l
 

##  修改 .ssh/config (没有则创建)

	Host liuzhangpei.github.com
	    HostName github.com
	    PreferredAuthentications publickey
	    IdentityFile ~/.ssh/id_rsa
	Host livenowhy.github.com
	    HostName github.com
	    PreferredAuthentications publickey
	    IdentityFile ~/.ssh/livenowhy

	其中 Host 随意即可



##  测试配置

  检查之前的配置是否正确:
    
    $ ssh -T git@liuzhangpei.github.com
    Hi liuzhangpei! You've successfully authenticated, but GitHub does not provide shell access.

    $ ssh -T git@livenowhy.github.com
    Hi livenowhy! You've successfully authenticated, but GitHub does not provide shell access.

##  现在就以下种情况给出不同的做法
  
  `1` 本地已经创建或已经clone到本地

    $ vi .git/config
    修改 [remote "origin"] 项中的url值


    [remote "origin"]
        url = git@livenowhy.github.com:livenowhy/my-hexo.git

    或者在Git Bash中提交的时候修改remote

	$ git remote rm origin
	$ git remote add origin git@livenowhy.github.com:livenowhy/my-hexo.git

  `2` clone仓库时对应配置host对应的账户
    
    $ git clone git@livenowhy.github.com:livenowhy/my-hexo.git

    git 放弃本地修改 强制更新
    git fetch --all
    git reset --hard origin/master
    git fetch 只是下载远程的库的内容，不做任何的合并 git reset 把HEAD指向刚刚下载的最新的版本