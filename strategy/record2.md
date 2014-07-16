
## 数学运算
Bash Shell中利用`let`, `(())`和`[]`执行基本的算数操作  
而在进行高级操作时，`expr`和`bc`这两个工具也会非常有用

### let命令  

		#!/bin/bash  
		no1=4;
		no2=5;
		let result=no1+no2;
		echo $result
`let`命令可以直接进行基本的算数操作  
当使用let时，变量名之前不需要再添加`$`

#### 自加/自减操作

		$ let no1++
		$ let no1--
#### 简写形式

		$ let no1+=6
		$ let no2-=5
### []操作符
操作符的使用方法和`let`类似

		$ result=$[no1+no2]
再`[]`也可以使用`$`前缀  

### (())操作符  

		$ result=$((no1+$no2))
### expr命令

		$ result=`expr 3 + 4`
以上这些方法仅仅用于整数运算,不支持浮点数  

### bc工具
用`bc`可以实现复杂的算数运算

		$ echo "4*0.56" | bc
#### 设定小数精度
`bc`可以识别一个特殊的变量`scale`,可以用来设置精度  


		$ echo "scale=2;3/8" | bc
		0.37

#### 进制转换
默认为10进制  
`ibase`是输入进制控制变量  
`obase`是输出进制控制变量  

		$ no=100
		$ echo "obase=2;$no" | bc
		1100100

#### 计算平方以及平方根  

		echo "sqrt(100)" | bc 







