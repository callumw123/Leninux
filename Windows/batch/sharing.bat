@echo off
goto main

:main 
goto sharing

:sharing
echo Disabling these is unlikely to cause the Computer harm 
echo but DEFINATELY disable those that look out of place
echo ones that are normally here include C$, D$, IPC$ and ADMIN$
echo it should be fine to disable them all
:getInput
net share
set /p inputDelShare=ENTER THE SHARE NAME OF THE ONE YOU WISH TO DISABLE(enter "nope" for none): 
goto disable

:disable
if "%inputDelShare%"=="nope" (
    echo done!
) else (
    echo chose to disable %inputDelShare%
    net share %inputDelShare% /DELETE
    goto getInput
)


