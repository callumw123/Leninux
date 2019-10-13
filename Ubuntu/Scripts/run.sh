#!/bin/bash

currentUser=$(whoami)

if [[ " $currentUser " != *"root"* ]];
then
	#Not root
	echo "The script must be run as root, use sudo!"
	exit
fi

#Check Directory
echo "Ensure you are running this script in the scripts folder!"
read -p "Continue (Y/N): " confirmation

if [[ " $confirmation " != *"Y"* ]];
then
	#Not confirmed
	echo "Operation Cancelled"
	exit
fi

gnome-terminal -x ./UpdaterScript.sh
gnome-terminal -x ./UserScript.sh
#gnome-terminal -x ./SystemScan.sh
