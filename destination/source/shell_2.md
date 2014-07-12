## 列出文件
使用`ls`命令  
    
### 查看目录下文件的类型  
	
	$ ls -F
列出当前目录下的文件，并且为不同类型的文件添加不同的后缀：
> 目录文件			`/`		
> 可执行文件			`*`		
> 符号链接文件		`@`
> FIFO命名管道文件	`|`
> socket文件			`=`
> 普通文件			不添加任何东西  

### 根据最后一次修改时间顺序排序	
最近修改的在前面  

	$ ls -lt
反转  

	$ ls -ltr
## 查看当前工作目录的逻辑路径和物理路径
符号链接就是windows里的快捷方式    
当当前工作目录是一个链接文件时，物理路径就是实际链接的路径，逻辑路径就是当前链接文件所在的路径  
若不是，逻辑路径和物理路径保持一致  
### 查看逻辑路径  
	
	$ pwd -L
### 查看物理路径   

	$ pwd -P
### 问题
在目录/proc/self下使用`pwd -p`，打印出来的物理路径为何与使用`ls -l /proc/self`得到链接路径不一致？  

## 切换到链接目录的物理路径  
`cd`也有两个选项`-L`和`-P`  
当目录名为里链接文件时，使用`-P`将切换到链接文件的物理路径  

## 已知一个文件的相对路径或绝对路径，获取其文件名或者文件所在路径   
我们往往在知道一个文件的路径的时候有如下两个需求：  
1. 仅获取该文件路径中最后的文件名  
2. 仅获取该文件路径中文件的所在路径  
**For example:**   
	
		$ path=/usr/src/linux-headers-3.13.0-24//include/media/tuner.h
获取文件名:  

		$ basename $path
		tuner.h  
获取文件名的时候，同时去除后缀:  

		$ basename $path .h
		tuner
获取文件所在路径:  
		
		$ dirname $path
		/usr/src/linux-headers-3.13.0-24//include/media  
## 查看目录的树形结构  
使用`tree`命令  

	$ tree -d -L 3 /home
`-d`只显示目录，`-L`指定目录深度
## 查看命令的二进制代码、源代码和手册页文件的路径名
请使用`whereis`,例如：  

		$ whereis google-chrome
		google-chrome: /usr/bin/google-chrome /usr/bin/X11/google-chrome /usr/share/man/man1/google-chrome.1

## 查找命令的位置  
使用	`which`，这个和`whereis`有些相似，根据环境变量$PATH查找命令的位置  
若是首先找到，则停止查找，显示结果    
可以使用`which -a`来查找所有位置(当命令具有多个位置时)  

## 查看文件内容  
### cat给显示的内容添加行号  
使用`cat -n`和`cat -b`给查看的文件添加行号  
`-b`选项去除了空行  
可以使用`wc -l`来验证`cat -n`的正确性  

### less和more
### head和tail
#### head查看文件前n行内容  
	
		$ head -n 5 /etc/passwd  
#### head查看文件前n个字节的内容  

		$ head -c 10 /etc/passwd
#### tail查看文件后n行内容  

		$ tail -n 3 /etc/passwd 
#### tail查看文件后n个字节的内容  

		$ tail -c 10 /etc/passwd
#### tail查看文件从第num行(包括num)之后的内容  

		# tail -n +num
#### 动态查看文件结尾出新添加的内容  
有两种方式:  
一种以文件描述符方式跟踪文件的增长;另一种是以文件名方式跟踪文件增长  
**文件描述符方式**

		$ tail -f /var/log/dmesg
**文件名方式**  

		$ tail --follow=name /var/log/dmesg
##### 两种方式的区别  
`tail -f`查看文件后10行后，并没有结束，而是一直运行，保持那个文件对应的索引节点的打开状态，这样就可以跟踪动态增长的文件。  
但是有的程序追加文件内容的时候，会将原文件删除，新建一个同名的文件，这样就无法跟踪了，因为新文件的索引节点改变，例如使用vim,gedit等编辑器。
  
可以在使用vim编辑文件前后，使用`ls -li`查看文件的inode验证  

`tail --follow=name`会以文件名进行跟踪，即使重新建一个文件，只要文件名没有改变，也会正确跟踪。
这样，如果当文件新追加内容是追加到同一名称的不同索引节点的情况发生时，那么tail那里就会提示 `tail: “tail_test” has been replaced;  following end of new file`之后再重新显示追加之后的新的最后10行。   

## 统计文件行数和字数  
### 显示文件的行数，字数，字节数  

		$ wc /etc/paaswd
		  35   57 1873 /etc/passwd  
这个命令的含义是下面三个命令的顺序集成  

		$ wc -l /etc/passwd
		35 /etc/passwd	  
		$ wc -w /etc/passwd  
		57 /etc/passwd
		$ wc -c /etc/passwd  
		1873 /etc/passwd
### 显示文件最长行的长度  

		$ wc -L /etc/passwd
		82 /etc/passwd


## 创建文件和目录  
平时我们可以使用`vim`或者`gedit`等编辑软件创建一个文件   
但是当仅仅创建一个新文件，使用它们就有点麻烦  
### 使用touch快速创建一个文件
	
		$ touch test  
		$ ls -l test
		-rw-rw-r-- 1 xiaizai xiaizai 0  7月  1 17:19 test

当前目录不存在`test`时，`test`被创建  
若存在，不会创建,只会`更改当前时间`为其`修改时间和访问时间`等信息，可以使用`ls -li`命令查看验证    
 
### 更改文件的访问时间和修改时间  
#### 仅更改访问时间为当前时间
	
		$ touch -a test
#### 仅更改修改时间为当前时间  

		$ touch -m test

#### 更改访问时间或修改时间为指定时间
`touch`命令使用`-t timestamp`和`-d str`来指定时间（两种指定方式不同）  
与`-a`或`-m`组合来用指定时间更改访问时间或修改时间  

`str`:解析指定的字符串，用以替代当前系统时间。  
写法相对自由，其中可以包括日期、时间、时区、周、相对时间、相对日期及数字串等。例如：“Sun, 26 Feb 2012 20:10:30 +0800”、“2012-02-26 20:10:40”,甚至“next Sunday”等  

`timestamp`:使用 \[[CC]YY]MMDDhhmm[.ss]来代替当前时间.  
CC为年数中的前两位，即”世纪数”；YY为年数的后两位，即某世纪中的年数．如果不给出CC的值，则把年数CCYY限定在1969--2068之内．MM为月数,DD为天数，hh 为小时数(几点)，mm为分钟数，SS为秒数．此处秒的设定范围是0--61，这样可以处理闰秒。

`-a`是更改访问时间（access time）;`-m`是更改最后一次修改时间  
### 递归的创建目录

		$ mkdir -pv zz/dd/ff
		mkdir: 已创建目录 "zz"
		mkdir: 已创建目录 "zz/dd"
		mkdir: 已创建目录 "zz/dd/ff"   
`-p`表示递归创建目录  
`-v`显示详细过程  

## 删除文件和目录  
### 提示删除文件

		$ rm -i decilious_food
		rm：是否删除普通文件 "decilious_food"？

### 删除目录 
空目录一般使用`rmdir`来删除，但是非空目录它就无能为力了  
`rm -r`递归的删除目录

		$ rm -r dir

### 强行删除，不加提示  

		$ rm -f file
## 重命名文件和目录  

		$ mv file1 file2
## 移动文件和目录  

	
