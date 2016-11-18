######
# Configure variables

$target = "C$\ABC_Bank\MerchantSoftware.exe"
$logPath = "F:\logs"
$csvPath = "F:\GetFileVersionScript\Devices.csv"
$password = "thepassword"

######
# Start Script

$csv = Import-Csv -Path $CsvPath | Where-Object {$_.Type -eq "POS"}

$logfile = $logPath + "\" + (Get-Date).toString('ddMMyyyy') + ".csv"

$results = New-Object psobject
$results | Add-Member -MemberType NoteProperty -name "DeviceID" -value $null
$results | Add-Member -MemberType NoteProperty -name "Version" -value $null

Export-Csv -InputObjects $results -Path $logfile

Foreach ($i in $csv) 
{

    net use ("\\" + $i.IPAddress) /user:Administrator $password | Out-Null
    $result = "{0},{1}" -f $i.DeviceName,((Get-Item -Path ("\\" + $i.IPAddress + "\" + $Target)).VersionFile.FileVersion)
    $result | Add-content -Path $logfile
    net use ("\\" + $i.IPAddress /delete) | Out-Null
    
}
    
