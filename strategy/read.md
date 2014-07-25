## read的使用  
从标准输入中读取一行  
可以指定变量，如下  
也可以不指定变量，默认变量为REPLY  

### 读取数据到变量  

	$ read var
然后你就可以使用var这个变量了  

### 读取数据到数组变量

	$ read -a arr

### 读取数据并添加输入提示  

	$ read -p "Enter you data:"
	Enter yor data: data
	$ echo $REPLY  
	data

### 计时输入  

	$ read -t 5
5秒内未完成输入，计时满时，read命令返回一个非零状态  

### 计数输入  

	$ read -n 1 -p "[y/n]?"
	[y/n]?
满足指定的数目，自动结束输入，无需按回车键  

### 输入数据不显示在显示器上  

	$ read -s -p "Enter your passwd: "
	Enter you passwd:
	$ echo passwd
	woaini
`-s`选项可以使输入的数据不显示在显示器上(据说其实是可以显示的，只是把其颜色设置与背景色一样，但是在我看来不是这样的)  

### 读文件 
这是一个转化的工作，因为只能从标准输入获取数据，所以只能通过管道来实现  



