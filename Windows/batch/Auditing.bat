@echo off
 
:main
echo Current Audit Policy settings (make sure you are running from admin cmd):
pause 
auditpol /get /category:*
echo creating new audit settings

REM turn on auditing for all categories
auditpol /set /category:* /success:enable /failure:enable
echo New Audit Policy settings:
pause
auditpol /get /category:*