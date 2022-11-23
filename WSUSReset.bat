IF EXIST C:\WSUSReset.txt GOTO:END

:CLEANUP
ECHO Cleanup >>C:\WSUSReset.txt
net stop wuauserv 
net stop bits 
net stop appidsvc 
net stop cryptsvc 
net stop ccmexec 

sc query wuauserv | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto END 
 
sc query bits | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto END 
 
sc query appidsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query appidsvc | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto END 
 
sc query cryptsvc | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 goto END 
 
sc query ccmexec | findstr /I /C:"STOPPED" 
if %errorlevel% NEQ 0 sc query ccmexec | findstr /I /C:"OpenService FAILED 1060" 
if %errorlevel% NEQ 0 goto END 

ECHO SCquery >>C:\WSUSReset.txt

del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
del /f /s /q %SystemRoot%\SoftwareDistribution\*.*  
del /f /s /q %SystemRoot%\system32\catroot2\*.* 
del /f /q %SystemRoot%\WindowsUpdate.log  
 
REM del /f /q "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 
REM ren %SystemRoot%\SoftwareDistribution *.bak 
REM ren %SystemRoot%\system32\catroot2 *.bak 
REM ren %SystemRoot%\WindowsUpdate.log *.bak 
 
REM sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU) 
REM sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU) 

ECHO delete >>C:\WSUSReset2016.txt
 
cd /d %WinDir%\system32 
regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll 

ECHO regsvr >>C:\WSUSReset2016.txt

REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f 
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f 
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f 

Delete C:\Windows\WindowsUpdate.log

del C:\Windows\servicing\Packages\Microsoft-Windows-InternetExplorer-*11*.*

ECHO Del_servicing >>C:\WSUSReset.txt

netsh winsock reset 
proxycfg.exe -d 
netsh winhttp reset proxy 
 
net start ccmexec 
net start cryptsvc 
net start appidsvc 
net start bits 
net start wuauserv 

ECHO Startup >>C:\WSUSReset.txt

bitsadmin.exe /reset /allusers 
 
wuauclt /resetauthorization /detectnow 

ECHO Complete >>C:\WSUSReset.txt

:END

exit
