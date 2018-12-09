#!/bin/bash

#This script updates security settings for linux scripts

#Declare Variables
path="/"
user=$SUDO_USER

#Display Msg
echo "Leninux, Cyber Centurion Security Protocols Updater"

#Check that the script is being run as sudo

currentUser=$(whoami)

if [[ " $currentUser " != *"root"* ]];
then
	#Not root
	echo "The script must be run as root, use sudo!"
	exit
fi


#Check forensic Questions Asked
echo "Are you sure you won't to update security setting, MAKE SURE YOU COMPLETE FORENSIC QUESTIONS FIRST"
read -p "Continue (Y/N): " confirmation

if [[ " $confirmation " != *"Y"* ]];
then
	#Not confirmed
	echo "Operation Cancelled"
	exit
fi

echo "Do you want to enable SSH server"
read -p "Enable SSH (Y/N): " sshenabled

#Execute Script


#Download Files from GitHub 
path="/home/"$user"/Desktop/security"
git clone https://github.com/callumw123/Leninux $path
path="/home/"$user"/Desktop/security/Ubuntu/SecurityFiles"
#copy files over

#Update Authentication Settings

cp $path/CommonPassword /etc/pam.d/common-password #Common Password
cp $path/CommonAuth /etc/pam.d/common-auth #Common Auth
cp $path/LoginDefs /etc/login.defs #Login Defs

tput setaf 2; echo "Security Settings Updated"; tput sgr0

#Setup SSH

if [[ " $sshenabled " == *"Y"* ]];
then
	#Update SSH
	apt install openssh-server
	cp $path/sshconfig /etc/ssh/sshd_config #ssh settings
	service ssh restart
	tput setaf 2; echo "SSH updated and secured"; tput sgr0
fi

#Disable Guest and usernames on login page

apt install lightdm
cp $path/Guest /etc/lightdm/lightdm.conf #Guest
tput setaf 2; echo "Guest Disabled"; tput sgr0

#Disable Root Login

passwd -l root	
	
tput setaf 2; echo "Root Login Disabled"; tput sgr0

#Enable Firewall

apt install ufw && apt install gufw
ufw enable

#Setup Firewall Settings

sysctl -n net.ipv4.tcp_syncookies #Enable sys Cookie Protection
echo net.ipv6.conf.all.disable_ipv6 | sudo tee -a /etc/sysctl.conf #Disable IPv6
sudo echo 0 | sudo tee -a /proc/sys/net/ipv4/ip_forward #Disable IP Forwarding

tput setaf 2; echo "Firewall Enabled"; tput sgr0

#Install and update antivirus (clamav)

sudo apt install clamav 
tput setaf 2; echo "Clamav Installed"; tput sgr0

#Setup Audit Policy
apt-get install auditd
auditctl -e 1
	
tput setaf 2; echo "Audit Policy Enabled"; tput sgr0

tput setaf 1; echo "All Security Settings Updated"; tput sgr0

#Start system update 

gnome-terminal -- sh -c "sudo apt upgrade && sudo apt update && tput setaf 1; echo 'System Updated'; tput sgr0; bash"

