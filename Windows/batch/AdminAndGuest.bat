@echo off
goto main

:main 
net user Administrator /active:no
echo Administrator
net user Administrator | findstr active
net user Guest /active:no
echo Guest
net user Guest | findstr active