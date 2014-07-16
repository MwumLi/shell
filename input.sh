#!/bin/bash 

num=1
#read line

cat  | while read line
do
	echo -e  "$num:$line\n"
    num=`expr $num + 1`
#	read line	
done

exit 0
