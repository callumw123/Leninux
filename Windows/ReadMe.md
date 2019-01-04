# Windows scripts

scripts for the automation of mundane tasks for the windows images.
Currently contains:
* Checker.ps1: checks users and admins on system against given files
* Basic Security.ps1: 
  - Flushes dns
  - disables sharing in c: drive
  - requires control alt delete at log on
  - enables firewall
  - disbales default accounts(Admin and Guest) 
  - enables automatic updating
  
 Adding files written in batch as they are guaranteed to work on all windows machines as last round we discovered that older versions of windows were running older versions of powershell which limited which part of the scripts would run.
 unlike callum's "all in one" bash script the batch scripts will be in different files 
 

## the command "Set-ExecutionPolicy unrestricted" must be run in an administrator powershell window 
