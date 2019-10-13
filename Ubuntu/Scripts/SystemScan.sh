#!/bin/bash

#Check that the script is being run as sudo

currentUser=$(whoami)

if [[ " $currentUser " != *"root"* ]];
then
	#Not root
	echo "The script must be run as root, use sudo!"
	exit
fi

mediaFileTypes=(png jpg bmp svg mp3 mp4 mov avi)

#Define functions

function runSystemScan {
	#Determine what scans should be carried out
	echo "Do you want to find all the installed applications (Y/N)"
	read -p ">>> " findapps
	if [[ " $findapps " == *"Y"* ]]; then
		findapps
	fi
	#Check if media files should be looked for
	echo "Do you want to find all the media files (Y/N)"
	read -p ">>> " findmedia
	if [[ " $findmedia " == *"Y"* ]]; then
		findmedia
	fi
}

function findmedia {
	#Find all the media files on the system
	for i in ${mediaFileTypes[@]}; 
	do
		tput setaf 1; echo "FILE TYPE: "$i; tput sgr0
		tput setaf 4; cd ..; sudo find . -type f -iname '*.'$i -printf '%h\n'|sort|uniq -c |awk '$1 > 1'; tput sgr0; 
	done
}

function findapps {
	#gets list of apps 
	tput setaf 4; for app in /usr/share/applications/*.desktop; do echo "${app:24:-8}"; done; tput sgr0
	
	#Find out if some programs should be deleted
	echo "Do you want to delete SOME of the applications listed (Y/N)"
	read -p ">>> " deleteapps

	if [[ " $deleteapps " != *"Y"* ]]; then
		#Don't delete programs, exit function		
		return
	fi

	#Declare array for holding programs to be deleted and array of progra s
	toDeletep=()

	program=$(for app in /usr/share/applications/*.desktop; do echo "${app:24:-8}"; done;)
	programs=(${program// / })
	

	echo ${programs[1]}
	echo ${programs[3]}

	echo "Type Y for every program you won't to delete, to keep the program press Enter"

	#loop through programs asking whether they should be deleted
	for p in "${programs[@]}" 
	do	
		#For each program ask whether it should be deleted
		tput setaf 2;		
		read -p "Delete "$p" (Y/N) >>> " deleteprogram
		tput sgr0	
		if [[ " $deleteprogram " == *"Y"* ]]; then
			#Add program to toDelete array
			toDeletep+=$p" "		
		fi
	done

	toDelete=(${toDeletep// / })
	#Check whether the programs should be deleted
	echo "Confirm Deletion of the Following Programs:"

	tput setaf 1;	
	num=1
	for a in "${toDelete[@]}"
	do
		echo $num") "$a
		num=$(($num+1))
	done
	tput sgr0

	#Print out values of array

	
	#Confirm Deletion
	echo "Type CONFIRM to delete the programs (THIS ACTION CANNOT BE UNDONE)"
	read -p ">>> " deleteconfirmation

	if [[ " $deleteconfirmation " == *"CONFIRM"* ]]; then
		#Delete all apps in toDelete array	
		for p in "${toDelete[@]}"
		do
			sudo apt remove $p
			echo $p" Removed"
		done
		#Display completion msg
		tput setaf 1; echo "ALL SELECTED PROGRAMS DELETED"; tput sgr0
	else
		echo "Operation Cancelled"
		clear	
	fi
}

#Welcome Msgs

echo "Leninux, Ubuntu System Scan"
runSystemScan
