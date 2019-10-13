#!/bin/bash

#Check that the script is being run as sudo

currentUser=$(whoami)

if [[ " $currentUser " != *"root"* ]];
then
	#Not root
	echo "The script must be run as root, use sudo!"
	exit
fi

#Define functions

function findfile {
	#If filename=0 then find only on filetype
	#If filetype=0 then find only on name
	filename=$1
	filetype=$2

	if [[ " $filetype " == *"0"* ]]; then
		#Search by name only
		tput setaf 1; sudo find / -type f -iname $filename"*"; tput sgr0
	elif [[ " $filename " == *"0"* ]]; then
		#Search by type only
		tput setaf 1; sudo find . -type f -name "*."$filetype; tput sgr0; 	
	else
		#Search by name and type
		tput setaf 1; sudo find / -type f -iname $filename"*."$filetype; tput sgr0
	fi
}

#Welcome Msgs

echo "Leninux, Ubuntu File Finder"
echo "Enter the file name (type 0 if you are searching by type only)"
read -p "File Name >>> " name
echo "Enter the file type excluding dot (type 0 if you are searching by name only)"
read -p "File Name >>> " ftype
findfile $name $ftype
