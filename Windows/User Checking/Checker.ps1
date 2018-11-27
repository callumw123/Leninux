$ActualUsers = Get-LocalUser | Select Name;  # will be a hash of users names
$ValidUsers = Get-Content .\AllowedUsers.txt; # requires all valid users to be in the allowedusers.txt file
$currentAdministrators = Get-LocalGroupMember -Group "Administrators" | Select Name; #a hash of all current admins;
$ValidAdministrators = Get-Content .\AllowedAdmins.txt;
$computerName = (Get-WmiObject -Class Win32_ComputerSystem -Property Name).Name;

Write-Host "The following usernames need to be checked and removed:";

#loop through usesrs actuall on this system and check if the file containing the autorised users contains them
foreach($username in $ActualUsers.Name){
    if(!$ValidUsers.Contains($username)){
        Write-Host $username;
    } 
}

#converts users to the same format used by the system: user => COMPUTERNAME\user
for($i = 0; $i -lt $ValidAdministrators.Length; $i++){
    $ValidAdministrators[$i] = $computerName + "\" + $ValidAdministrators[$i] ;
}

Write-Host;
Write-Host "The following users are admins that dont match your list on this system:";
#loops through admins on the system and checks them against the authoried users file
foreach($admin in $currentAdministrators.Name){
    if(!$ValidAdministrators.Contains($admin)){
        Write-Host $admin;
    }
}
