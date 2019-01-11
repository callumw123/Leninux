@echo off

goto main 

:main
REM enable dont display last username 
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "dontdisplaylastusername" /t REG_DWORD /d 1 /f
goto CADPol

:CADPol
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DisableCAD" /t REG_DWORD /d 0 /f
ver | findstr /i "6\.0\." > nul
if %ERRORLEVEL% EQU 0 (
echo OS = Vista / Server 2008
echo You ought to check that actually worked in secpol 
)
ver | findstr /i "6\.1\." > nul
if %ERRORLEVEL% EQU 0 (
echo OS = Windows 7 / Server 2008R2
echo You ought to check that actually worked in secpol 
)
ver | findstr /i "6\.2\." > nul
if %ERRORLEVEL% EQU 0 (
echo OS = Windows 8 / Server 2012
)
ver | findstr /i "6\.3\." > nul
if %ERRORLEVEL% EQU 0 (
echo OS = Windows 8.1 / Server 2012R2
)

