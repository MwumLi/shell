## 数组与关联数组  

Bash同时支持普通数组和关联数组  
普通数组只能使用整数作为数组索引  
而关联数组可以使用字符串作为数组索引  

### 普通数组  

#### 定义数组  

		$ var = (2 3 5 7) 
#### 打印数组元素  

		$ echo ${var[2]}
		3
		$ echo ${var[*]}   //打印所有元素  == echo ${var[@]}
		2 3 5 7
#### 打印数组长度  

		$ echo ${3var[@]}
		4

### 关联数组  

#### 定义数组  
需要先声明一个变量名为关联数组  

		$ declare -A arr
将元素添加到关联数组  
1. 利用内嵌索引-值列表法  

		$ arr=([index1]=val1 [index2]=val2)
2. 利用独立索引-值进行赋值  

		$ arr[index1]=val3

#### 列出数组索引  

		$ echo ${!arr[*]}   //同理echo ${!arr[@]}
		index2 index1  
这个也可以用于普通数组  
