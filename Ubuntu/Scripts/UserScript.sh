#!/bin/bash

#Display Msg
echo "Leninux, Cyber Centurion User Updater"

#Check that the script is being run as sudo

currentUser=$(whoami)

if [[ " $currentUser " != *"root"* ]];
then
	#Not root
	echo "The script must be run as root, use sudo!"
	exit
fi

#Get nums of admins and users

echo "Enter the Number of Authorised Adminstrators"
read -p ">>> " adminnums

echo "Enter the Number of Authorised Users"
read -p ">>> " usernums

echo "Enter the name of the primary admin account (password will not be changed)"
read -p ">>> " primaryadmin


#Get Adminstrators
admins=()
i=0

while [ $i -le $(($adminnums-1)) ]
do
	#Get each admins name
	read -p "Enter Admin "$(($i+1))" Name: " name
	admins+=($name)   
	#Increment Counter
	i=$(($i+1))
done

#Get Users
users=()
i=0

while [ $i -le $(($usernums-1)) ]
do
	#Get each users name
	read -p "Enter User "$(($i+1))" Name: " name
	users+=($name)   
	#Increment Counter
	i=$(($i+1))
done


#echo ${admins[*]}
#echo ${users[*]}

#Confirm choices
echo "Please confirm the users and admins list"
echo "Admins: "${admins[*]}
echo "Users: "${users[*]}
read -p "Confirm (Y/N) " confirmation

if [[ " $confirmation " != *"Y"* ]];
then
	#Not confirmed
	echo "Operation Cancelled"
	exit
fi


#Get the list of all current users
names=$(cat /etc/passwd | grep -v nologin | grep "/home/" | awk -F':' '{print $1}')
declare -a allCurrentUsers
allCurrentUsers=(${names// / })

#Get list of admins

cadmins=$(grep -Po '^sudo.+:\K.*$' /etc/group)
declare -a currentAdmins
IFS=',' read -ra currentAdmins <<< "$cadmins"

#Get list of Standard Users
declare -a currentStandardUsers

for u in "${allCurrentUsers[@]}"
do	
	#For each user check if they are admin
	if [[ " ${currentAdmins[*]} " != *$u* ]]; then
		#User is not admin
		#Add to stand users
		currentStandardUsers+=($u)
	fi
done

#echo ${currentAdmins[*]}
#echo ${currentStandardUsers[*]}
#echo ${allCurrentUsers[*]}

#record changes
changes=()

#check each supposed standard user

for u in "${users[@]}" 
do
	#check they are not admin
	if [[ " ${currentAdmins[*]} " == *$u* ]]; then
		#user is admin
		#change them to standard user
		#echo "Admin "$u" changed to Standard User"
		#change to user
		deluser $u sudo
		changes+=("Admin "$u" changed to Standard User")
	fi
done

#check each supposed admin 

for u in "${admins[@]}" 
do
	#check they are admin
	if [[ " ${currentAdmins[*]} " != *$u* ]]; then
		#user is not admin
		#change them to admin
		#echo "user change to admin "$u
		#change to admin
		usermod -aG sudo $u
		changes+=("Standard User "$u" changed to Admin")
	fi
done

#check all current users are allowed

for u in "${allCurrentUsers[@]}"  
do
	#check each user is authorised
	if [[ " ${admins[*]} " != *$u* ]]; then
		#user is not admin
		if [[ " ${users[*]} " != *$u* ]]; then
			#user is not standard user
			#user is unauthorised, delete them
			#echo "unauthorised "$u
			#delete user
			userdel $u
			changes+=("Unauthorised User "$u" Deleted")
		fi
	fi
done

#echo ${changes[@]}

#Update the list of all current users
names=$(cat /etc/passwd | grep -v nologin | grep "/home/" | awk -F':' '{print $1}')
declare -a allCurrentUsers
allCurrentUsers=(${names// / })

#change passwords of all users to QwertY123!$

for u in "${allCurrentUsers[@]}"  
do
	if [[ " $u " != *"$primaryadmin"* ]];
	then
		#not primary admin, change password
		echo $u":QwertY123!$" | sudo chpasswd
	fi
done

#Write change file

echo "Change Log:" >> UserLog.txt
echo " " >> UserLog.txt
for c in "${changes[@]}"  
do
	echo $c >> UserLog.txt
done
echo " " >> UserLog.txt
echo "Passwords Changed to 'QwertY123!$'" >> UserLog.txt
