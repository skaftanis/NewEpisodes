#!/bin/bash

#this script used to check now a spesifique entry of the program

#print the menu with all names of entries

	#create an array with movies/serries names 
	#find lines of name.txt
	LINES=`wc -l < names.txt`
	#create the array
	k=1 #helping var
	counter=1
	for i in `seq 1 $LINES`; do
		if [ `expr $i % 2` -ne 0 ]; then
		temp=`sed -n "${i}p" names.txt`
		if [ "$temp" != "NULL" ]; then 		
			array[k]=$temp
		else
			counter=`expr $counter + 1`
		fi
		k=`expr $k + 1`
		fi		
	done
	if [ $counter -eq $k ]; then 
		zenity --info --text="Empty List! Please Enter an Serrie first!"
	else
	#choose movies/serrie (20 serries maximum)
	VCNAME=`zenity  --height 200 --width 500 --list --text="Choose the movie/serrie you want to edit" --column='' ${array[1]} ${array[2]} ${array[3]} ${array[4]} ${array[5]} ${array[6]} ${array[7]} ${array[8]} ${array[9]} ${array[10]} ${array[11]} ${array[12]} ${array[13]} ${array[14]} ${array[15]} ${array[16]} ${array[17]} ${array[18]} ${array[19]} ${array[20]}`
		#echo $VCNAME
		if [ $? = 1 ]; then
			exit
		fi
	fi

#fix CHOICE string bug. it was appeara as mpla|mpla for some reason (zenity problem)
NOL=${#VCNAME} #number of letters of CHOICE
NOLDT=`expr $NOL / 2` #number of letters div 2
VCNAME=${VCNAME:0:$NOLDT}	


#read link and code for file of the selected entry
VCLINK=`sed -n "1p" $VCNAME` #link is in the first line of it
VCCODE=`sed -n "3p" $VCNAME` #code it's on third line

#echo VCLINK
#echo VCCODE

#export viriables
export VCNAME
export VCLINK
export VCCODE

#call check script
bash check.sh

