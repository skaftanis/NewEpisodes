#!/bin/bash

#this is the setup script. help to add a new movie/serrie in the list

#starting message and save the message to variable ENTRY
#exit program if user hits cancel button
LINK=`zenity  --height 200 --width 500 --entry --text="Give the website "`
if [ $? = 1 ]; then
	exit
fi
NAME=`zenity  --height 200 --width 500 --entry --text="Give movie/series name (NO SPACES)"`
if [ $? = 1 ]; then
	exit
fi
CODE=`zenity  --height 200 --width 500 --entry --text="Give movie/series code"`
if [ $? = 1 ]; then
	exit
fi


#names.txt saves the names of movies/serries. There is a blank line down
#of every event

echo -e "$NAME\n"  >> names.txt

#copy the link, the code and the name in a file named like movies/serrie name
echo -e "$LINK\n" > "$NAME"
echo -e "$CODE\n" >> "$NAME"
echo -e "$NAME\n" >> "$NAME"

#default reload frequency = every day = 86400 seconds. 
#seconds placed in the last line of the file 
echo -e "86400\n" >> "$NAME"

#place started seconds in sutabled name file 
echo 86400 > "startsec $NAME"


