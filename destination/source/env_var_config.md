## Linux下的环境变量配置文件  
1. `/etc/profile`	--->全局配置文件，对于每个用户都起作用  
2. `~/.profile`		--->个人用户配置文件  
3. `~/.bashrc`		--->个人终端配置文件
当然，Linux下不止这些文件，因为本人使用的是`ubuntu-14.04`,故主要介绍ubuntu环境下  
## 配置文件的加载顺序  
具体加载顺序和shell的类型有关  

### 判断shell的类型
shell分为login shell和non-login shell,还分为interactive shell和non-interactive shell  

* 假如是一个login shell:  

		$ echo $0
		-bash
命令结果包含字符`-`  
* 假如是一个non-login shell:  

		$ echo $0
		bash
命令结果不包含字符`-`  
* 假如是一个interactive shell:  

		$ echo $-
		himBH  
命令结果包含字符`i`  
* 假如是一个non-interactive shell:  

		$ echo $-
		hBc
命令结果不包含字符`i`  

### 配置文件的具体加载顺序  
介绍两种常见的  
1. login and interactive shell 例如：字符终端(Ctrl+Alt+[1-6])  

		首先加载/etc/profile
		然后加载~/.bashrc
		最后加载~/.profile
当然这些文件必须存在(一般情况下都存在)  
2. non-login and interactive shell 例如：虚拟终端(teriminal)  

		首先加载/etc/profil
        然后加载~/.profile
        最后加载~/.bashrc 
`teriminal`是在图像界面下打开的一个软件,而每打开一个`teriminal`,都会重新加载`~/.bashrc`,至于其他两个文件，只会在系统登录时加载一次  

