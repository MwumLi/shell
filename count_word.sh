#!/bin/bash 

function count(){
	if [ $# != 1 ]
	then
		echo "Need one fil parameter to work!"
		exit 1
	fi

	#set sort language environment
	LC_ALL=C

	#use space to replace all punctuation characters 
	#use space to replace all horizontal or vertical whitespace
	#use space to replace all control characters
	#use space to replace all digits
	tr '[:punct:]' ' ' <$1 | tr '[:space:]' ' ' | \
	tr '[:cntrl:]' ' '| tr '[:digit:]' ' ' |\
	
	#transfer uppercase to lowercase
	tr '[:upper:]' '[:lower:]' | \

	#squeeze repeat characters
	tr -s ' ' | \
	
	#use new line to replace space 
	tr ' ' '\n' | \
	
	#delete empty line
	sed '/^$/d' | \

	#sort by ascii
	sort | \
	
	#count and delete repeat characters, but keep fisrt
	uniq -c | \
	
	#sort by count result(1 segment) ,  reverse the order
	sort -rn -k 1

}

echo
echo "The script can count words of a specified file."

while :
do
	read -p "Enter the path(or quit): "
	case $REPLY in
		[Qq]|[Qq][Uu][Ii][Tt])
			echo "Bye,thanks for your using!"
			exit 0
			;;
		*)
			if [ -f "$REPLY" ] && [ -r $REPLY ] && [ -s $REPLY ]
			then
				count $REPLY
			else
				echo "$REPLY can not be dealed with."
			fi
			;;
	esac
done
exit 0

