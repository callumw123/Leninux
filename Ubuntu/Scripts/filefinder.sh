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
	toDelete=()

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
			toDelete+=$p		
		fi
	done

	#Check whether the programs should be deleted
	echo "Confirm Deletion of the Following Programs"

	#Print out values of array

	
	#Confirm Deletion
	echo "Type CONFIRM to delete the programs (THIS ACTION CANNOT BE UNDONE)"
	read -p ">>> " deleteconfirmation

	if [[ " $deleteconfirmation " == *"CONFIRM"* ]]; then
		#Delete all apps in toDelete array	
		for p in "${toDelete[@]}"
		do
			: apt remove $p
		done
		#Display completion msg
		tput setaf 1; echo "ALL SELECTED PROGRAMS DELETED"; tput sgr0
	else
		echo "Operation Cancelled"
		clear	
	fi
}





#Welcome Msgs

echo "Leninux, Ubuntu File Finder"
echo "Do you want to carry out system scan (S) or individual file search (I)"
read -p ">>> " optype

if [[ " $optype " == *"I"* ]]; then
	echo "Enter the file name (type 0 if you are searching by type only)"
	read -p "File Name >>> " name
	echo "Enter the file type excluding dot (type 0 if you are searching by name only)"
	read -p "File Name >>> " ftype
	findfile $name $ftype
fi

if [[ " $optype " == *"S"* ]]; then
	runSystemScan
fi






