##  Perciville WAN Toggle 23/11/22

## Be sure to check your NIC Interface names first and customise as needed.
## netsh interface show interface

clear
ping 8.8.8.8 -n 1
$ONLINE = $LASTEXITCODE
if ($Online -eq 0)
{
write-host "You'r Online - - - Going Dark"
netsh interface set interface "Ethernet" Disable
netsh interface set interface "WiFi" Disable
 }
 if ($Online -eq 1)
{
write-host "You're Offline - - - Bringing you back online"
netsh interface set interface "Ethernet" enable
netsh interface set interface "Wifi" enable
 }
