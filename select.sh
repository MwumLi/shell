#!/bin/bash 

#! /bin/bash
select i in mon tue wed 
do
	case $i in
		mon)
			echo 'Monday';break;;
		tue)
			echo 'Tuesday';break;;
		wed)
			echo 'Wednesday';break;;
		*)
			echo 'not exist!';;
	esac
done
