## 输入输出重定向

### 标准输入
文件描述符0  

### 标准输出
文件描述符为1  
标准输出默认显示到终端显示屏幕上  
#### 重定向标准输出到文件

		command > standard.out
		command 1> standard.out
#### 重定向引起的格式不统一
使用`ls > test`,我们会发现发现`test`文件的内容和在标准输出的格式不一，而是每一项占据一行  

这个并不是重定向的原因，而是`ls`命令本身决定，`ls`的开发者在源码中进行了判断：如果执行ls命令时标准输出被重定向了，就以行的格式输出(ls -1)，因为这样更符号用户的习惯  

如果希望`ls`重定向后的内容不会发生改变(即以列显示)，请使用`ls -C`强制改变  

#### 多命令输出重定向到一个文本

		$ { date;df;uptime;} > test 
  

#### 将命令结果嵌入到字符串中


		$ echo "`date`"
或者
		$ echo ha$(pwd)
shell扫描一遍命令行，发现了$(cmd)结构，便将$(cmd)中的cmd执行一次，得到其标准输出，再将此输出放到原来命令。有些shell不支持，如tcsh。  

#### bash的noclobber
执行`set -o noclobber`,命令行一旦进行重定向，文件存在，则报错，不存在，则bash像往常一样创建文件  
使用`>|`可以跳过此选项  
默认是关闭这个选项的，可以使用`set +o noclobber`关闭  

#### `>|`这又是什么

### 标砖错误输出
文件描述符为2  
标准错误输出默认也显示到终端显示屏幕上
#### 重定向标准错误输出到文件

		conmand 2> standard.error
#### 重定向标准输出和标准错误输出到同一个文件

		command &> same.out
或  

		command >& same.out 
或  

		command >same.out 2>&1
或  

		commadn 2>same.out >&2

第一种是比较新的方式，bash手册上比较推荐第一种   
第三种和第四种其实一种方式,其中`2>&1`和`>&2`是一个整体(不能添加空格)  
`&`表示指定的数字是一个文件描述符  
对了第四种方式`&>2`前面没有东西，那就是默认为1(标准输出)   

#### 将错误定向到`黑洞`

		commmand 2> /dev/null 

`/dev/null`是Linu系统中的一个特殊的文件，它表示一个空设备  
但是实际系统中没有这样一个硬件设备  
它是被虚拟出来的，就像黑洞一样，只要数据丢到这个设备中，数据就会消失  

### 管道  

#### 需求1
把`/etc/passwd`中每一行根据字母排序  
同时在排序之后添加行号  
结果输出到终端，并同时保存在sort.out文件中  

##### 解决方案

	#!/bin/bash 

	sort /etc/passwd | cat -n | tee sort.out 

##### 讨论
`sort`将`/etc/passwd`的每一行按照字母顺序排序  
排序结果通过管道传递给`cat`命令   
`cat -n`给每一行添上行号，最后通过管道传递给`tee`  
`tee`把结果放到标准输出和指定的文件中  

`tee`的语法:它复制他的标准输入到标准输出及每一个指定的文件FILE中.可以同时指定多个FILE,得到同样的内容。它就像有一输入口，多个输出口的管道，这多个输出口中有一默认的输出口---标准输出，其它需要指定  
`tee`的命令格式:  

	tee [option] ... [FILE] ...

#### 需求2
当我们需要删除目录树中所有，以`.out`结尾的文件，可以用管道来实现吗？可能你很快想到下面这个方案：   

	$ find . -name "*.out" | rm
	rm: missing operand
	Try 'rm --help' for more information.
可以看到，报错了,为什么这样呢?  
其实`rm`命令在删除文件的时候有，指定给它的文件路径只是它的参数，并不是它的输入，也就是说，`rm`命令实际上并不接受任何标准输入，而只接受命令行参数。  

##### 解决方案  
使用shell的命令替换  


	#!/bin/bash 

	#使用命令替换$(command)的方法使得命令command的输出作为命令行参数
	#删除当前目录下所有以.out为后缀的文件  
	rm -i $(find . -name "*.out")
	
	#另一种命令替换的方法  
	rm -i `find . -name "*.out"`

	exit 0

##### 讨论 
命令替换的两种形式：  

	$(command)
	或者
	`command`
这两种形式都是用命令command的输出替换掉了命令本身  
由于command的标准输出中所有换行符被空格取代，所以若干行文件路径的输出就变成了命令行上的若干个参数  

##### 重要提示  
程序的输入和命令行的参数是完全不同的两个东西  
只有需要输入数据的命令才能放到管道符号`|`后面  

### 块语句的输出和重定向  
Shell脚本中有很多块语句的结构，如if语句、for语句等  
重定向不只是可以用到简单的命令调用上，还可以应用到这些块语句上  

#### 需求1
Shell脚本中一次执行多个命令  

##### 解决方法  

	#!/bin/bash  

	#把多个命令的输出一起重定向到文件中
	#{ command1;command2;...; } 中两个大括号前后必须有空格
	#因为它是Shell的保留关键字  '
	#command之间必须有;隔开，最后一个command也必须有空格  
	{ date;cd /etc; echo -n "pwd:"; pwd; } > block.out
	cat block.out

	#()是当前执行脚本的shell的子shell
	#故其前后空格无所谓
	#而且最后一个命令也可以不要分号
	(date;cd /etc; echo -n "pwd:"; pwd) > block.out
	cat block.out
	
	#输出当前工作目录
	pwd

##### 讨论 
上述两种方法效果一样，但是机制却不一样  
第一种是把多个命令的输出集合在一块  
第二种却是把一个子shell的输出重定向  
可以从结果脚本结果验证这一点  

#### 需求2
读取用户指定的任意文本文件，在每一行的前面添加行号以后，保存到当前目录的.out扩展名的文件中  

##### 解决方案  
使用了while循环快的标准输入/输出实现  


	#!/bin/bash  

	echo
	echo -n "Specify a text file path:"

	#读取用户输入的文件
	read file

	echo
	
	count=0

	filename=`basename $file`

	while read FILE
	do

		count=$((count+1))
		echo $count:$line

	done < $file > $filename.out
	
	echo "Output file is $filename.out"

	exit 0

### Here Document
使用格式：  

		$ command << delimiter
		>Document
		>Document
		>Document
		...
		>Document
		>delimiter

这些`Document`包含在`delimiter`之间，作为`command`的输入，很明显`delimiter`是一个分隔符  

### 文件描述符  
`exec`关联一个文件描述符到一个文件   

		#打开文件file并把其关联到文件描述符fd
		#如果文件已存在，则覆盖文件并写入数据
		exec fd> file

		#以追加的方式向文件中写入数据  
		exec fd>> file 
使用这两种方式关联以后，就可以在脚本使用这个文件描述符了  
`exec`也可以关联一个描述符到一个存在的文件描述符：  

		exec fd2>&fd1
使用操作符<>打开的文件描述符可以同时读/写文件  

		exec fd <>input_output_file
关闭文件描述符:  

		exec fd>&-




















