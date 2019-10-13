# Leninux
CCV Files for Leninux

6 Scripts:

1) Downloader.sh (Ubuntu)
2) Run.sh (Ubuntu)
3) UpdaterScript.sh (Ubuntu)
4) UserScript.sh (Ubuntu)
5) SystemScan.sh (Ubuntu)
6) FileFinder.sh (Ubuntu)

#Downloader (Ubuntu)

Use this to download the scripts. First copy the script over to the test image and run it. The script will download all the scripts and security files from github and give them permission to run.

IMPORTANT NOTES:

1) ALWAYS run as root
2) ALWAYS run in the desktop directory
3) You must give the script permission to run (sudo chmod +x [directory])

#Run (Ubuntu)

Run this script at the start of the round, the script will run the updater script, user script and system scan.

IMPORTANT NOTES:

1) ALWAYS run as root
2) ALWAYS run in the scripts directory
3) You must give the script permission to run (sudo chmod +x [directory])

#Updater Script (Ubuntu)

The updater script setups the recommended security settings for:

1) Password Policy
2) Lockout Policy
3) Install SSH (optional)
4) Disable SSH root login (optional)
5) Enable FTP (optional)
6) Disable FTP plain text authentication (optional)
7) Disable Guest Account
8) Disable Autologin
9) Disable Usernames on login screen
10) Disable root login
11) Enable Firewall
12) Enable firewall logging
13) Enable SYN cookie protection
14) Disable IPv6
15) Disable IP Forwarding
16) Enable firewall spoof protection
17) Install antivirus (clamav)
18) Install antivirus (clamtk)
19) Setup Audit Policy
20) Enable Automatic Updates
21) Update and Upgrade System

IMPORTANT NOTES:

1) ALWAYS run as root
2) COMPLETE ALL Forensics Questions First
3) ALWAYS run in the desktop directory
4) You must give the script permission to run (sudo chmod +x [directory])

#User Scripts (Ubuntu)

You enter the users/admin and it changes all passwords to secure ones, delete unauthorised users and check only authorised admins have admin privledges 

IMPORTANT NOTES:

1) ALWAYS run as root
2) COMPLETE ALL Forensics Questions First
3) ALWAYS run in the desktop directory
4) DOUBLE check the users name (lowercase only)
5) You must give the script permission to run (sudo chmod +x [directory])

#System Scan (Ubuntu)

A script that will display all the installed applications and allow you to select which ones need deleting. It also displays all the media files found on the computer.

IMPORTANT NOTES:

1) ALWAYS run as root
2) Double check which application are to be deleted
3) You must give the script permission to run (sudo chmod +x [directory])

#File Finder (Ubuntu)

A script which will locate files based on name and/or filetype. 

IMPORTANT NOTES:

1) ALWAYS run as root
2) You must give the script permission to run (sudo chmod +x [directory])
