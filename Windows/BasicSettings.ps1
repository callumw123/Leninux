###Flush dns
ipconfig /flushdns;

###Disables sharing on the C: drive
net share C$ /DELETE;
net stop lanmanserver;

###Enables control alt delete to log on
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DisableCAD" /t REG_DWORD /d 0 /f;

###Enable firewall for public, private and domain networks
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True;

###Disable Administrator and Guest accounts
Disable-LocalUser Administrator;
Disable-LocalUser Guest;

###Enable automatic updates
$currentUpdateSettings = (New-Object -com "Microsoft.Update.AutoUpdate").Settings;
Write-Host $currentUpdateSettings;
$currentUpdateSettings.NotificationLevel = 4;
$currentUpdateSettings.Save();
