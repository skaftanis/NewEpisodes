#!/bin/bash

#this script remove completly an entry for the program

#create an array with movies/serries names 
	#find lines of name.txt
	LINES=`wc -l < names.txt`
	#create the array
	k=1 #helping var
	counter=1;
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
#echo counter $counter
#echo k $k
if [ $counter -eq $k ]; then 
zenity --info --text="Empty List! Please Enter an Serrie first!"

else 
#choose movies/serrie (20 serries maximum)
CHOICE=`zenity --list --text="Choose the movie/serrie you want to remove" --column='' ${array[1]} ${array[2]} ${array[3]} ${array[4]} ${array[5]} ${array[6]} ${array[7]} ${array[8]} ${array[9]} ${array[10]} ${array[11]} ${array[12]} ${array[13]} ${array[14]} ${array[15]} ${array[16]} ${array[17]} ${array[18]} ${array[19]} ${array[20]}`
if [ $? = 1 ]; then
	exit
fi

#confirmation dialog
zenity --question --text="All information for $CHOICE will be belete! Are you sure?"
if [ $? = 1 ]; then
	exit
fi
#remove the file with all information
if [ $? = 0 ]; then
	rm $CHOICE
	rm "startsec ${CHOICE[i]}"
fi
#remove show name from names.txt file (replace it with NULL)
	OLD=$CHOICE
	NEW=NULL
	sed -i "s/$OLD/$NEW/g" names.txt

fi

