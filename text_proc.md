## 文本处理和字符串操作  
### 常用的文本操作  
#### 需求1 
从一个目录中获取最近访问的5个普通文件，并且只输出文件名和访问时间  

#### 解决方案  

		$ ls -lut | grep "^-" | head -n 5 | cut -c32-
		Jul 21 22:05 shell_2.md
		Jul 21 21:18 shell_1.md
		Jul 18 23:22 shell_3.md
		Jul 18 20:38 test
		Jul 18 20:38 set_terimal.md

#### 讨论  
	`grep "^-"`取出以`-`起始的行,`-`是普通文件的标志  
	`cut -n32-`取出每行中从第32字符开始到当前行结束的数据  
#### cut命令  
剪切命令  
使用`-b`选项指定会保留并输出那些字节，其余部分会删除  
使用`-c`选项指定会保留并输出那些字符，其余部分会删除  
配合`-f`选项仅选择指定的字段,使用`-d`指定字段分隔符替代默认制表符  
`-b`,`-c`和`-f`每次只能选择一个  
`-b`,`-c`和`-f`同时还需要`list`选项配合选择:  
1. n	第n个字节、字符或字段  
2. n-	从第n个字节、字符或字段开始直至行尾  
3. n-m	第n--m个字节、字符或字段  
4. -m	第1--m个字节、字符或字段  

	$  cat /etc/passwd | head -n 5| cut -d : -f 1,2,6,7
	root:x:/root:/bin/bash
	daemon:x:/usr/sbin:/usr/sbin/nologin
	bin:x:/bin:/usr/sbin/nologin
	sys:x:/dev:/usr/sbin/nologin
	sync:x:/bin:/bin/sync

#### 需求2  
假如有两个文件name.txt和tel.txt，分别存储着员工的姓名和电话号码  
如果希望把两个文件中的用户名和电话号码一一对应起来,该如何做呢?
(姓名和电话号码分属两个文件，但是同行)  

	$ cat -n name.txt
    1	liluo
	2	liujia
	3	wangdan
	4	zhangbaoqing
	5	suweiqiang
	6	lihuan
	7	wuwenhao
	8	lijunning
	$ cat -n tel.txt
	1	13022881595
	2	13045211236
	3	15833652364
	4	16433665524
	5	12536499655
	6	13585654454
	7	13054687645
	8	15434864789
	$ paste -d ':' name.txt tel.txt | cat -n
    1	liluo:13022881595
    2	liujia:13045211236
    3	wangdan:15833652364
    4	zhangbaoqing:16433665524
    5	suweiqiang:12536499655
    6	lihuan:13585654454
    7	wuwenhao:13054687645
    8	lijunning:15434864789
#### 讨论  
`paste`命令用来连接多个文件对应行  
默认没有选项，会使用`tab`来连接  
`paste`也使用`-d`来指定分隔符,分隔符只能是一个字符  
`paste`也能合并来自标准输入的数据，使用`-`来表示标准输入  

#### 需求3
检查系统中的各种shell程序（例如bash）,统计出它们各被多少个用户所使用，并把统计结果按照从多到少的顺序打印出来  

#### 解决方案  

	$ cat /etc/passwd | cut -d ':' -f 7|sort|uniq -c|sort -nr
	16 /usr/sbin/nologin
	14 /bin/false
	2 /bin/bash
	1 /bin/sync
	1 /bin/sh 
	
#### 讨论 
`sort`--文本数据排序  
默认情况下根据环境变量`LC_ALL`进行排序，`LC_ALL=C`表示英文语言环境，按照ASCII排序；`LC_ALL=zh_CN.utf8`,将会按照中文拼音顺序排序中文数据    
选项：
	-b 忽略杭寿的空格或制表符等空白字符  
	-d 字典排序  
	-f 排序时忽略大小写,转化成大写，然后排序  
	-M 按照月份排序  
	-n 按照字符串表示的算数数值排序，空字符串为0  
	-r 逆序  
	-c 检测制定文件按是否已经排序，如果排序妥当，返回0，不输出任何信息；否则，显示其中第一个不符合排序规则的文本数据行，返回1
	-u 确保排序结果的唯一性，当排序关键字相同而出现重复现象时，仅选取其中第一个出现的文本数据行;当与`-c`选项配合使用，检查排序是否完成的同时，还要检测是否存在重复的文本数据行  
	-t 指定分隔符,默认为空格或制表符  
	-k 指定排序关键字的起止字段及字符位置，格式为-k pos1,[pos2],pos1为起始字段，pos2为结束字段；pos的格式为f[.c],f表示字段，c表示f字段的c字符  
	-o 指定排序结果文件，而非标准输出  
例如：  
1. 以`:`为分隔符，按照用户ID的数值从小到大排序，在终端显示排序后的/etc/passwd文件  

		$ sort -t ':' -n -k 3 /etc/passwd 
2. 从分机号码的第3位开始，重排电话号码，然后写入新文件  

		$ sort -k 2.3 -o newphonebook  phonebook 

`uniq`--显示或忽略重复的文本数据行  
读取指定输入文件，合并相邻的重复数据行，把唯一的数据行及合并后的数据行(仅保留第一个出现的数据行)写到制定输出文件  
选项：  
	-c 在输出的数据行之前插入一个行计数字段，表示多少行合并成当前行  
	-d 仅显示重复行  
	-u 仅显示非重复行  

使用`uniq`有两个条件限制：  
1. 让每一个单词都占用单独一行，因为uniq的基本操作单位是文件中的行  
2. 相同的行或单词要紧密连接在一起，而不能离散的分散在文件中，因为只有紧密相连，uniq命令才会把它们合并在一起  

`tr`--删除或替换字符  
`tr`命令从标准输入删除或替换字符，并将结果写入标准输出  
`tr option str1 str2`是基本格式  
option:  
* 没有选项，但是替换过str1和str2，就执行字符替换功能  
 
 1. 如果输入数据中的字符与str1中指定的任何一个字符相同，使用str2中相应位置的字符进行替换  
 2. 必须保证len(str1)==len(str2)，所以`len(str1)>len(str2)`,那么重复str2最后一个字符，直至len(str2)==len(str1);如果`len(str1)<len(str2)`,那么忽略str2后面的超长部分  
*For Example:*  
小写转换成大写  

		$ tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ  
		$ tr [a-z] [A-Z]
		$ tr '[:lower:]' '[:upper:]'

* -c --complement 仅指定时`-c`,使用str1的补集，按照升序替换str1,然后执行字符转换    
*For Example:*  
使用非字母数字替换str1,然后执行字符串中的转化，把输入数据中的非字母数字转换成换行  

		$ tr -c '[:alnum:]' '[\n*]'
* -d --delete 仅指定`-d`时，删除输入数据中与str1中字符相同的字符;如果同时指定`-d -c`,意味着保留和str1相同的字符，删除不相同的字符(此时不应该指定str2,除非指定了`-s`)   
*For Example:*  

		$tr -d '\r'	//删除输入数据中的回车字符  
		$tr -cd '[:digit:]' //删除除数字之外的任何字符  

* -s --squeeze-repeats 当某个字符(str1中的)连续出现，只保留第一个，其余删除;当同时指定'-d -s',str1用于删除指定的字符，str2用于压缩重复的字符，在此情况下str1和str2不能相同   
*For Example:*  
删除水平空白字符，压缩重复换行符  

		$ tr -sd '[:blank:]' '\n'
当仅仅指定`-s`选项的情况下，如果仅指定str1,str1的内容用于压缩重复字符串  
如果同时指定str1和str2，那么str1的字符被str2替换，同时str2用于压缩重复字符  
*For Example*  
	
		$ tr -s '\n'	//多个换行符压缩成单个换行符
		$ tr -s '[:blank:]' '[\n*]' 
第二个表示空白字符转换成换行符，最后压缩重复的换行符  

* 转义字符  
       \NNN   character with octal value NNN (1 to 3 octal digits)  

       \\     backslash  

       \a     audible BEL  

       \b     backspace  

       \f     form feed  

       \n     new line  

       \r     return  

       \t     horizontal tab  

       \v     vertical tab  

* 一些字符集  

[CHAR1-CHAR2]  
		all characters from CHAR1 to CHAR2 in ascending order  

[CHAR*]  
		in SET2, copies of CHAR until length of SET1  

[CHAR*REPEAT]
        REPEAT copies of CHAR, REPEAT octal if starting with 0

[:alnum:]  
        all letters and digits  

[:alpha:]  
        all letters  

[:blank:]  
        all horizontal whitespace  

[:cntrl:]  
		all control characters  

[:digit:]  
		all digits  

[:graph:]  
		all printable characters, not including space  

[:lower:]  
        all lower case letters  

[:print:]  
		all printable characters, including space  

[:punct:]  
        all punctuation characters  

[:space:]  
		all horizontal or vertical whitespace  

[:upper:]  
        all upper case letters  

[:xdigit:]  
      all hexadecimal digits  

[=CHAR=]  
        all characters which are equivalent to CHAR  

### TAB和空格的相互转换
#### TAB扩展成空格 
使用`expand`可以把TAB扩展成同等宽度的空格  
命令格式：`expand file`  
结果输出到标准输出 
#### 空格转化成TAB  
默认只转化行开头的空格  
命令格式：`unexpand file`  
需要全部转化，使用`-a`参数  
结果输出到标准输出   

### 文本文件在UNIX/Linux和Windows平台的转换  
在Ubuntu/Linux下，可以安装`tofrodos`：  

	$ sudo apt-get install tofrodos  
然后你就可以使用`fromdos`和`todos`  
`fromdos`:把windows系统文件转化成Linux下的文件格式 
`todos`:把Linux系统文件转化成windows格式  
有些Linux下，可以使用'unix2dos'和'dos2unix'实现同样的功能  

### 表格处理  
`column`：使输入数据形成列表  
命令格式：`column -t files`  
- -t 创建一个表  
- files 文件列表,也可以处理标准输入  
*For Example:*  

	${printf "Perm Links Owner Group Size Month Day "; \
	printf "HH：MM/YEAR NAME\n"; \
	ls -l| sed 1d| column -t}
	PERM        LINKS  OWNER  GROUP  SIZE  MONTH  DAY  HH:MM/YEAR  NAME
	-rw-rw-r--  1      liluo  liluo  5     Jul    16   23:50       -
	-rwxrwxr-x  1      liluo  liluo  111   Jul    23   00:18       aa.sh
	-rwxrwxr-x  1      liluo  liluo  184   Jul    22   22:46       count_word.sh
	-rw-rw-r--  1      liluo  liluo  1952  Jul    16   01:32       descrack.c
	drwxrwxr-x  7      liluo  liluo  4096  Jul    19   21:15       jquery
	drwxrwxr-x  3      liluo  liluo  4096  Jul    19   22:26       learngit
	-rw-rw-r--  1      liluo  liluo  71    Jul    21   22:52       name.txt
	-rw-rw-r--  1      liluo  liluo  63    Jul    24   00:49       num.txt
	-rw-rw-r--  1      liluo  liluo  359   Jul    16   01:29       pas.c

