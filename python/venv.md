## python3 创建虚拟环境

### 使用 venv

1、创建虚拟环境

    $ mkidr /pvenv
    $ cd /pvenv
    $ python3 -m venv venv_dir  # 创建虚拟环境 venv_dir, 会自动生成 venv_dir 文件夹
    
2、激活虚拟环境
    
    $ cd venv_dir/
    
    $ source venv_dir/bin/activate
    $ pip install package
    激活环境后所有的操作都在该虚拟环境中进行，不会到全局的python环境和其它python虚拟环境。
    
    退出虚拟环境
    $ ./bin/deactivate
    
    删除虚拟环境
    $ rm -rf venv_dir
    删除虚拟环境目录即可删除虚拟环境(已安装的python包都会被删除)