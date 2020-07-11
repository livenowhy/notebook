# git init 版本库初始化

## git 配置

    git config -global user.name "Your name"
    git config -global user.email "you@example.com"

## 添加用户

    # groupadd gitgroup
    # useradd syh-b
    # passwd syh-b
    # usermod -G gitgroup syh-b
    # vi /etc/passwd

    编辑/etc/passwd文件完成
    syh-b:x:1001:1001:,,,:/home/git:/bin/bash
    改为:
    syh-b:x:1001:1001:,,,:/home/git:/usr/bin/git-shell
    这样，syh-b用户可以正常通过ssh使用git，但无法登录shell，因为我们为git用户指定的git-shell每次一登录就自动退出。

## git init 和 git init –bare 的区别 ( bare [beə] 空的;赤裸的,无遮蔽的)

  `1` git init 创建本地仓库(在工程目录下创建)
  `2` git init --bare 创建远端仓库(在服务器或者工程目录以外路径都可以创建的备份仓库)
      工程commit到1中，push到2中

  用"git init"初始化的版本库用户也可以在该目录下执行所有git方面的操作。
  但别的用户在将更新push上来的时候容易出现冲突。
  
  比如有用户在该目录(就称为远端仓库)下执行git操作,且有两个分支(master 和 b1), 当前在master分支下。
  另一个用户想把自己在本地仓库（就称为本地仓库）的master分支的更新提交到远端仓库的master分支，他就想当然的敲了

    git push origin master:master

  于是乎出现:
  因为远端仓库的用户正在master的分支上操作,而你又要把更新提交到这个master分支上，当然就出错了。

  但如果是往远端仓库中空闲的分支上提交还是可以的，比如

    git push origin master:b1   还是可以成功的

  解决办法就是使用”git init –bare”方法创建一个所谓的裸仓库，之所以叫裸仓库是因为这个仓库只保存git历史提交的版本信息，而不允许用户在上面进行各种git操作，如果你硬要操作的话，只会得到下面的错误（”This operation must be run in a work tree”）
  这个就是最好把远端仓库初始化成bare仓库的原因。



    
    当创建一个普通库时,在工作目录下,除了.git 目录之外, 还可以看到库中所包含的所有源文件。
    你拥有了一个可以进行浏览和修改(add, commit, delete等)的本地库。
    当你创建一个裸库时,在工作目录下,只有一个.git目录,而没有类似于本地库那样的文件结构可供你直接进行浏览和修改。
    但是你仍旧可以用git show命令来进行浏览，举个例子（参数为某个commit的SHA1值）：
    
    # git show 921dc435a3acd46e48e3d1e54880da62dac18fe0
    一般来说，一个裸库往往被创建用于作为大家一起工作的共享库，每一个人都可以往里面push自己的本地修改。一个惯用的命名方式是在库名后加上.git，举个例子：
    
    # mkdir example.git
    # cd example.git
    # git init --bare .
    这样你便拥有了一个叫做example的共享库。在你自己的本地机器上，你可以用git remote add命令做初始化check-in：
    
    // assume there're some initial files you want to push to the bare repo you just created,
    // which are placed under example directory
    # cd example
    # git init
    # git add *
    # git commit -m "My initial commit message"
    # git remote add origin git@example.com:example.git
    # git push -u origin master
    项目团队里面的每个人都可以clone这个库，然后完成本地修改之后，往这个库中push自己的代码。