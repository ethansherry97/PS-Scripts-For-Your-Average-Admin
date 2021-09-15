## Searches AD and moves expired users to a certain OU
search-ADAccount -AccountExpired -UsersOnly | move-adobject  -targetpath "ENTER OU HERE"


$users = get-adobject -filter {objectclass -eq "user"} -searchbase "ENTER OU HERE" -Properties DistinguishedName,Name,Objectclass,objectguid,description

$date = Get-Date -Format "MM-dd-yyyy"

foreach ($User in $users)
{
    $UserID = $user.ObjectGuid
    
    Set-ADObject $UserID -replace @{mailNickname=$UserID}

    Set-ADObject $UserID -replace @{msExchHideFromAddressLists=$true}
    Set-ADObject $UserID -clear ShowinAddressBook

    Disable-ADAccount -Identity $UserID -Confirm:$false

    $UserDescription = get-aduser $UserID -Properties Description |select Description
    if ($UserDescription.Description -match "Disabled on") {} else {
    Set-ADUser $UserID -Description "$($UserDescription.Description) (Disabled on $Date)"
    }
}