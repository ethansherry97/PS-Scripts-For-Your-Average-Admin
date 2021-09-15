$PbkPath = Join-Path $env:PROGRAMDATA 'Microsoft\Network\Connections\Pbk\rasphone.Pbk'

$ConnectionName = '  '
$ServerAddress = ' '
$PresharedKey = ' '

If ((Test-Path $PbkPath) -eq $false) {
$PbkFolder = Join-Path $env:PROGRAMDATA "Microsoft\Network\Connections\pbk\"

if ((Test-Path $PbkFolder) -eq $true){
New-Item -path $PbkFolder -name "rasphone.pbk" -ItemType "file" | Out-Null
}

else{
$ConnectionFolder = Join-Path $env:PROGRAMDATA "Microsoft\Network\Connections\"
New-Item -path $ConnectionFolder -name "pbk" -ItemType "directory" | Out-Null
New-Item -path $PbkFolder -name "rasphone.pbk" -ItemType "file" | Out-Null
}
}

Remove-VpnConnection -AllUserConnection -Name $ConnectionName -Force -EA SilentlyContinue
Add-VpnConnection -Name $ConnectionName -ServerAddress $ServerAddress -DnsSuffix ccric.local -AllUserConnection -TunnelType L2tp -L2tpPsk $PresharedKey -AuthenticationMethod Pap -EncryptionLevel Optional -Force -WA SilentlyContinue
Start-Sleep -m 100
Set-VpnConnection -Name $ConnectionName -SplitTunneling $False -AllUserConnection -WA SilentlyContinue
$Destination = '10.0.0.0/24'

Add-Vpnconnectionroute -Connectionname $ConnectionName -AllUserConnection -DestinationPrefix $Destination

(Get-Content -path $PbkPath -Raw) -Replace 'UseRasCredentials=1','UseRasCredentials=0' | Set-Content -pat $PbkPath

$IconLocation = "%SystemRoot%\System32\SHELL32.dll"
$IconArrayIndex = 18
$ShortcutFile = "$env:Public\Desktop\VPN.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = "rasphone.exe"
$ShortCut.WorkingDirectory = "$env:SystemRoot\System32\"
$Shortcut.IconLocation = "$IconLocation, $IconArrayIndex"
$Shortcut.Save()

$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\PolicyAgent"
$Name = "AssumeUDPEncapsulationContextOnSendRule"
$value = "2"
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null