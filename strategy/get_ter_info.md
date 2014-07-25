## tput

### 获取终端行数和列数  

		$ tput cols
		$ tput lines
### 打印当前终端名  

		$ tput longname
### 将光标移动到方位(100,100)  

		$ tput cup 100 100  

### 设置终端背景色  

		$ tput setb no
其中，no可以在0到7之间取值  

### 设置终端前景色  

		$ tput setf no  
其中，no也是0--7 

### 设置文本样式为粗体  

		$ tput bold
### 设置下划线起止  

		$ tput smul

		$ tput rmul

## stty
再输入密码的时候，不能让输入的内容显示出来。  
利用`stty`我们实现这个需求:  


	#!/bin/bash 

	echo -e "Enter passwd:";
	stty -echo  
	read passwd
	stty echo 
	echo
	echo $passwd
