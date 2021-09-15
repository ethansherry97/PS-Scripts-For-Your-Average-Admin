Write-Host '*********************'
Write-Host 'Account Killer 2021'
Write-Host '*********************'
$account = Read-Host 'Enter AD Account'
$date = Read-Host "Enter Date in Format xx/xx/xx"
$date2 = [DateTime]$date
Set-ADAccountExpiration -Identity $account -DateTime $date2.AddDays(1)
Write-Host '*********************'
Write-Host '*********************'
Write-Host $account 'has been set to expire at Close of Business' $date
Write-Host '*********************'
Write-Host '*********************'

$outfile = "C:\Scripts\Verification_Files\deactivatedUsers.csv"
$newcsv = {} | Select "Employee", "Date_Deactivated" | Export-CSV $outfile
$csvfile= Import-CSV $outfile
$csvfile.Employee = $account
$csvfile.Date_Deactivated = Get-Date
$csvfile | out-file $outfile -Append