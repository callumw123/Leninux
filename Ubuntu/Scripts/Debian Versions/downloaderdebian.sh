#!/bin/bash

#Check that the script is being run as sudo

currentUser=$(whoami)

if [[ " $currentUser " != *"root"* ]];
then
	#Not root
	echo "The script must be run as root, use sudo!"
	exit
fi

#Check if git is installed

if hash git 2>/dev/null; then
	#installed
	echo "Git Installed"
else
	echo "Git Not Installed"
	echo "Installing git"
  	apt-get update
	apt-get install git-core
fi

#Download git respositry 

user=$SUDO_USER
path="/home/"$user"/Desktop/Leninux"

git clone https://www.github.com/callumw123/leninux $path

#Copy scripts and guides onto desktop
pathscript="/home/"$user"/Desktop/Scripts"
pathguides="/home/"$user"/Desktop/Guides"

path1=$path"/Ubuntu/Scripts"
path2=$path"/Guides"

cd /

sudo cp -r $path1 $pathscript
sudo cp -r $path2 $pathguides

#Remove rest of files
sudo rm -r $path

#Give script permission
scriptpath="/home/"$user"/Desktop/Scripts/*.sh"

for file in $scriptpath; do
	chmod a+x $file
done 

clear

tput setaf 2; echo "Scripts downloaded and setup for execution"; tput sgr0
