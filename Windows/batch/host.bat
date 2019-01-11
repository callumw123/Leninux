@echo off
echo Clearing contents of: C:\Windows\System32\drivers\etc\hosts
attrib -r -s C:\WINDOWS\system32\drivers\etc\hosts
echo #lorne woz here > C:\Windows\System32\drivers\etc\hosts
attrib +r +s C:\WINDOWS\system32\drivers\etc\hosts
echo Cleared hosts file
echo if that didnt work then i would suggest completely emptying it