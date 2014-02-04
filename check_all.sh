#!/bin/bash

#this script used to check all active entry at once with button Check All 

#save neccesairy information in arrays!

	k=1
	#find lines of name.txt
	LINES=`wc -l < names.txt`

    #NON (number of names)
	NON=0
	#save all serries names in CNAME array
	for i in `seq 1 $LINES`; do
		if [ `expr $i % 2` -ne 0 ]; then
			CNAME[k]=`sed -n "${i}p" names.txt`
			NON=`expr $NON + 1`
			k=`expr $k + 1`
		fi	
	done

	#save all serries links in CLINK array
	for i in `seq 1 $NON`; do
		CLINK[i]=`head -n 1 ${CNAME[i]}`
		#echo ${CLINK[i]}
	done

	#save all serries codes in CCODE array
	for i in `seq 1 $NON`; do
		CCODE[i]=`sed -n '3p' ${CNAME[i]}`
	done
	

	#check all 

	for i in `seq 1 $NON`; do
		if [ "${CNAME[i]}" != "NULL" ]; then
			VCNAME=${CNAME[i]}
			#echo $VCNAME
			VCCODE=${CCODE[i]}
			#echo $VCCODE	
			VCLINK=${CLINK[i]}
			#echo $VCLINK
			export VCNAME
			export VCCODE
			export VCLINK
			bash check.sh
		fi
	done

	
