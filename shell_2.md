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

### 显示当前目录所有文件大小
单位为k  

	$ ls -s 
可以显示更为人性化的单位效果  

	$ ls -sh

### 排序  
#### 省略常规，按照文件在目录中自然存储顺序依次列出  

	$ ls -U
	$ ls --sort=none
#### 按照文件扩展名进行排序  

	$ ls -X
	$ ls --sort=extension  
#### 显示文件大小，并按照文件大小进行排序  
文件越大越靠前  

	$ ls -S
	$ ls --sort=size

#### 按照文件最近修改时间排序  
最新修改的在前  

	$ ls -t 
	$ ls --sort=time  
#### 按照文件节点修改时间排序  
文件节点变化，即文件创建  

	$ ls -c 
	$ ls -ltc	//按照创建时间排序 ，并显示创建时间  
显示创建时间，但按照名字排序  
	
	$ ls -lc

### 显示文件指定的时间  
#### 显示atime

	$ ls -l --time=atime
	$ ls -l --time=access
	$ ls -l --time=use
#### 显示信息节点状态改变时间  

	$ ls -l --time=ctime  
	$ ls -l --time=status
	$ ls -lc 

#### 显示最近修改时间  

	$ ls -lt  
### 以行的格式输出文件列表

	$ ls -1
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
当目录名为链接文件时，使用`-P`将切换到链接文件的物理路径  

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
### 展示非打印字符  
`cat -T`	  
	show TAB characters as `^I`  
`cat -v`  
	show nonprinting , use ^ and M- notation, except for LFD and TAB  
`cat -t` == `cat -vT`
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
### 移动单个文件到指定目录下
移动`source/debug.sh`到目录`destination`下  

		$ mv source/debug.sh destination/
		$ ls destination/
		debug.sh

### 移动多个文件到指定目录下
		$ mv -t destination source/select.sh source/shell_1.md
		$ ls destination/
		debug.sh  select.sh  shell_1.md

### 避免覆盖原有文件
`mv`命令默认不会判断目标路径是否存在相同文件名的文件  
为避免破坏目标路径已有文件，请使用`-i`参数

## 建立文件和目录的链接
### 链接是什么
链接就是指向另一个文件的文件。  
使用链接可以在多个目录中保存统一文件的拷贝  
对链接文件的编辑（增加、删除、修改）都会映射到原文件和其他链接文件  
事实上，并不是拷贝，因为他们并没有复制原文件的内容  

#### 链接分为硬链接和软链接  
在Linux系统中，文件的唯一标识就是inode 
##### 硬链接  
硬链接和原文件的inode是一样的，故硬链接和原文件基本一样，只是路径不同  
硬链接的缺点也很明显：不能在不同的文件系统间建立硬链接  
故硬链接现如今已基本不在使用   
##### 软链接
软链接是新的文件(inode和原文件不一样),它只是保存了原文件的路径，打开软链 接，就是根据保存的原文件的路径打开对应文件  

软链接因为根据路径寻文件，故可以在不同文件系统间建立链接  
当软链接建立完成，然后移动原文件的路径，软链接就会失效，会被当作一个空白的新文件,此时，若是对此链接文件进行操作，会再次在相同位置形成原文件，只是原文件的内容已被当前操作所替换。

### 建立链接
默认建立硬链接

		$ ln file hard_link
建立软链接  

		$ ln -s file soft_link


## 复制文件和目录

### 复制文件

		$ cp source_file dest_file
### 复制目录
`cp`默认情况下会忽略目录，因此复制目录需要`-r`

		$ vp -r source_dir/ dest_dir  
### 复制符号链接或者链接指向的文件  
`-L`会复制符号链接所指向的文件  
`-P`只是复制符号链接这个文件  

## 文件所有者和访问权限  
对于目录来说，若是具有可执行权限，就可以通过`cd`命令进入目录  

如果目录没有设置执行权限位，则读/写权限都不会起作用。这是因为当读取目录中的内容时，首先要进入这个目录，此时没有可执行权限，进入目录就会失败。   

同样地，如果一个目录只拥有可执行权限，而没有读/写权限，同样不能查看目录的内容和在目录中创建文件   

删除文件时需要注意：能否在目录中删除一个文件，不是看用户对这个文件本身是否有可写权限，而是看用户对该文件的父目录是否有写的权限和可执行权限。如果用户对文件没有写的权限而对其父目录有可写权限，仍然可以删除它。

### 查看文件和目录的权限  
查看文件的权限

		$ ls -l   file
		-rw-rw-r-- 1 xiaizai xiaizai 6805  7月  2 10:49 file
查看目录权限  

		$ ls -ld dir
		drwxrwxr-x 2 xiaizai xiaizai 4096  7月  2 13:59 dir/

### 修改文件和目录的权限 
`chmod`命令  
#### `chmod`的符号表达式形式  

		$ chmod (who)(action)(permissions) file
`who`：`u`-->文件所有者，`g`-->文件所属组的用户，`o`-->其他用户，`a`-->所有用户  

`action`：`+`-->添加后面的权限，`-`-->删除后面的权限，`=`-->直接明确指定权限  
`permissions`：`r`-->可读权限，`w`-->可写权限，`x`-->可执行权限，`t`-->黏着位，`s`-->SUID和SGID  

`who`的参数是可以组合的，比如`ug`就可以用同时对所有者、组用户进行权限操作  

#### `chmod`的八进制形式  
文件的权限用一个四位八进制数表示，并作为一个整体一起指定，而不是分别对某一个对象（u,g,o）添加或删除权限的  

四位八进制数的第一位与后三位是不同的，第一位用来设置SUID,SGID和黏着位  
四位八进制数的后三位分别用来对文件所有者，文件属组，以及其他用户设置读写可执行权限

SUID--->4	SGID--->2	黏着位--->1  
读-->4		写-->2		可执行-->1  

一般情况下，我们只是更爱文件的可执行权限，因此只需要三位八进制数字，向下面这样:  

		$ chmod 644 file
		$ ls -l file
		-rw-r-r-- 1 xiaizai xiaizai 6805  7月  2 10:49 file
第一位对拥有者赋予可读可写，第二位和第三位分别对同组用户和其他用户赋予可读权限  

如果需要设置SUID,SGID和黏着位，那么就需要四位八进制数,像下面这样  
  
		$ chmod 5644 file
		$ ls -l file
		-rwSr-r-T 1 xiaizai xiaizai 6805  7月  2 10:49 file
第一位对`file`设置了SUID和黏着位,第二、三、四位分别设置了属主、属组和其他用户  
		
#### SUID、SGID和黏着位
##### SUID的作用  
`SUID`是set uid的缩写，顾名思义，只能对文件的所有者设置
 设置了`SUID`,普通用户就拥有了文件所有者对于文件的权限，例如`passwd`命令,更改密码时，我们并不需要`sudo`
**设置了SUID,文件权限显示有以下两种情况**:    
1. 当文件所有者没有可执行权限，则显示`S`
2. 当文件所有者有可执行权限，则显示`s`  
 
##### SGID的作用  
`SGID`是set gid的缩写，顾名思义，只能对文件的属组设置  
设置了`SGID`,普通用户就拥有了文件属组对于文件的权限  

**设置了SGID,文件权限显示有以下两种情况**:    
1. 当文件属组没有可执行权限，则显示`S`
2. 当文件属组有可执行权限，则显示`s`

##### 黏着位的作用  
`黏着位`(sticky bit)只能对其他用户进行设置，且只对目录起作用    
设置了`黏着位`，这个目录中的文件只能被三类用户删除：目录所有者，被删除文件的拥有者，以及超级用户  

**设置了黏着位,文件权限显示有以下两种情况**:    
1. 当其他用户没有可执行权限，则显示`T`
2. 当其他用户有可执行权限，则显示`t`  
### 修改文件的所有者和所属组  
`chown`是change owner的缩写,但是根据选项既可以改变属主，也可以改变属组    
`chgrp`是change group的缩写,尽可以改变属组  

下面的`owner`和`group`，既可以是用户名或组名，也可以是uid或gid  

#### 仅改变文件属主为owner  

		$ sudo chown owner file
#### 改变文件属主为owner，同时改变文件属组为owner所属的组
	
		$ sudo chown owner: file
#### 改变文件属主为owner,改变文件属组为group  

		$ sudo chown owner:group file
#### 仅改变文件属组为group

		$ sudo chown :group file
		$ sudo chgrp group file
这两条命令作用一致  


	
