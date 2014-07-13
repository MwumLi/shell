#### 根据名字寻找所有进程
	
		$ pgrep bash
		2452
		2588
		3978
#### 查看进程运行时的环境变量
`/proc/PID/environ`为进程`PID`的环境变量文件  
`PID`为进程号  
使用`cat`,`less`,`more`查看

		$ cat /proc/PID/environ   
在`/proc/PID/environ`中，环境变量之间是以`\0`分割的，可以用`\n`替换，例如：  


		$ cat /proc/PID/environ | tr '\0' '\n'
每一个环境变量单独成行

#### 一个常见的错误
`var=value`被写成`var = value`  
在脚本语言中，前者是赋值操作，后者是比较操作

#### 统计一个变量的长度
`var`是变量名,则其内容长度为`#var`
打印输出：  

			$ echo ${#var}

#### 判断一个用户是否为超级用户

			if [ $UID -ne 0 ]; then
			echo "Non root user.Please run as root"
			else
			echo "Root User"
			fi   
