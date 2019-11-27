get-DnsClientServerAddress 
echo ""
$ID = Read-Host -Prompt 'please insert Interfece Index'
#get-DnsClientServerAddress -InterfaceIndex $ID | Select-Object ServerAddresses   
echo "first"
$first =  (get-DnsClientServerAddress -InterfaceIndex $ID  |  where-Object {$_.SystemName -like 2} | Select-Object ServerAddresses).ServerAddresses
Write-Host $first
Set-DnsClientServerAddress -InterfaceIndex $ID -ServerAddresses {8.8.8.8, 8.8.4.4}
Write-Host "google..."
$second =  (get-DnsClientServerAddress -InterfaceIndex $ID  |  where-Object {$_.SystemName -like 2} | Select-Object ServerAddresses).ServerAddresses
Write-Host $second
$test = (Test-Connection google.com -Count 1).ReplySize -lt 1 
if ($test){
Set-DnsClientServerAddress -InterfaceIndex $ID -ServerAddresses $first
}
else {
echo changed!
}
$rev = Read-Host -Prompt 'Revert?(y/n)'
$brev = ($rev -like "y")

if ($brev)
{
Set-DnsClientServerAddress -InterfaceIndex $ID -ServerAddresses $first ;
echo (get-DnsClientServerAddress -InterfaceIndex $ID  |  where-Object {$_.SystemName -like 2} | Select-Object ServerAddresses).ServerAddresses
echo "changed back!"
}
pause
