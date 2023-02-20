$scriptPath = $PSScriptRoot
$driverPath = Join-path $scriptPath "NAMEOFFILE.EXE"

# Install process
$process = Start-Process -FilePath $driverPath -ArgumentList "/s" -Wait -PassThru
$errorcode = $process.ExitCode


if ($errorcode -eq 0)
{
	Write-Host "Error code: $errorcode"
	exit 0
}
else
{
	Write-Host "Installation Failed"
	Write-Host "Error code: $errorcode"
	exit $errorcode
}