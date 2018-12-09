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
** the command "Set-ExecutionPolicy unrestricted" must be run in an administrator powershell window **
