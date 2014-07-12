### Linux下设置环境变量  
有两种途径：配置文件添加和直接在命令行添加  

这两种方式的的区别就是作用范围不同  

命令行添加，仅限于当前shell  
而配置文件添加，则是全局性的，当然，因为配置文件的加载时序不同，则起作用时间也不同(`~/.profile只有重新进入系统才有效，~/.bashrc新建一个终端立即生效`)

#### 注意  
要说明一点，配置文件的生效可以使用`source`命令  

	$ source 配置文件
至于`source`的具体用法，使用`help source`查看

### 环境变量的定义  

	export ME="liluo"
和  

	ME="liluo"
	export ME
这两种方式就是用来定义环境变量的，实际效果完全一样  

### 环境变量的引用  
需要在环境变量名前添加`$`,例如:  

	$ echo $ME
	liluo
	$ export ME="$ME is me"  
	$ echo $ME
	liluo is ME
### 查看环境变量  
* 查看某一具体环境变量  

		$ echo $ME
* 查看所有的环境变量  

		$ env		或者
		$ print env
* 查看使用`export`导出的变量  

		$ export -p

