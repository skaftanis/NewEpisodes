#!/bin/bash

#this is check script. From here the programm will chech the code word in the site you want

#this script imports variable VCNAME, which is the name of serrie, VCLINK which is the link and VCCODE which is the code for check
#it also predict the next episode if it's in torrent episode format (S07E02 )

#TODO να βάλω αρχικές τιμές στα αρχεία notification type και mail.txt

#get the chosen notification type 
TYPE=`cat notification_type.txt`

#get the mail
MAIL=`cat mail.txt`

#how many times VCCODE appear toV CLINK
COUNT=`curl -s "$VCLINK" | grep -c "$VCCODE"`



if [ $COUNT -ne 0 ]; then
	#send the notification 
	if [ $TYPE = "Desktop|Desktop" ]; then
		notify-send "A new Episode of $VCNAME" "is available! Episode $VCCODE"
		sleep 1
		zenity --info --text="A new Episode of $VCNAMEis available! Episode $VCCODE"
	fi

	if [ $TYPE = "Mail|Mail" ]; then
		echo "A new Episode of $VCNAME" "is available!  Episode $VCCODE" | mail -s "NewEpisode Notification ( $VCNAME )" $MAIL
	fi

	if [ $TYPE = "Both|Both" ]; then
		echo "A new Episode of $VCNAME" "is available  Episode $VCCODE" | mail -s "NewEpisode Notification ( $VCNAME )" $MAIL
		notify-send "A new Episode of $VCNAME" "is available"
		zenity --info --text="A new Episode of $VCNAMEis available! Episode $VCCODE"
	fi

	#trying to guess the next episode name ( if it's in this format: S07E02 (season 7 episode 2)like 	torent sites )
	temp=${VCCODE:4:3}  #saves 02 ( of S07E02 )
	first=${VCCODE:4:1} #saves 0  ( of S07E02 )
	last=${VCCODE:5:1} #saves 2 ( of S07E02 ) 
	if [ $first -eq 0 ]; then
		if [ $last = '9' ]; then
			first=1
			last=0
		else
			first=0
			last=`expr $last + 1`
		fi
		NEXT=${VCCODE:0:4}$first$last #build the guess of next episode
	else
	temp=`expr $temp + 1`
	NEXT=${VCCODE:0:4}$temp	 #build the guess of next episode
	fi
	zenity --question --text="Next Episode of $VCNAME is $NEXT?"
	if [ $? = 0 ]; then
		#if next episode guess is correct change it from names.txt
		zenity --question --text="Do you want to set it for the next check?"
		if [ $? = 0 ]; then
			cat $VCNAME | sed -e "s/$VCCODE/$NEXT/" > next.txt
			cat next.txt > $VCNAME
			rm next.txt
		else
			echo o	
		fi

	else 
		NEXT=`zenity --entry --title="Set next episode" --text="Type the name of the next episode. Leave the field blank if there is not other episode"`
		cat $VCNAME | sed -e "s/$VCCODE/$NEXT/" > next.txt
		cat next.txt > $VCNAME
		rm next.txt
		if [[ $NEXT = '' ]]; then
			zenity --question --text="Do you want to Remove $VCAME?"
				if [ $? = 0 ]; then 
					#remove every information like Remove.sh
					rm $VCNAME
					rm "startsec ${VCNAME}"
					OLD=$VCNAME
					NEW=NULL
					sed -i "s/$OLD/$NEW/g" names.txt
				#else
					#TODO VCDODE στην τρίτη γραμμή 	
				fi
		fi
	   
	fi
fi
if [ $COUNT -eq 0 ]; then
        #send the notification
	notify-send "There is no new episode of $VCNAME"
fi


