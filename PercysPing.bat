@echo off
mode con: cols=91 lines=36

echo "                                                                                                 "
echo "8888888b.                                     d8b               8888888b.  d8b                   "
echo "888   Y88b                                    88P               888   Y88b Y8P                   "
echo "888    888                                    8P                888    888                       "
echo "888   d88P  .d88b.  888d888  .d8888b 888  888 "  .d8888b        888   d88P 888 88888b.   .d88b.  "
echo "8888888P"  d8P  Y8b 888P"   d88P"    888  888    88K            8888888P"  888 888 "88b d88P"88b "
echo "888        88888888 888     888      888  888    "Y8888b.       888        888 888  888 888  888 "
echo "888        Y8b.     888     Y88b.    Y88b 888         X88       888        888 888  888 Y88b 888 "
echo "888         "Y8888  888      "Y8888P  "Y88888     88888P'       888        888 888  888  "Y88888 "
echo "                                          888                                                888 "
echo "                                     Y8b d88P                                           Y8b d88P "
echo "                                      "Y88P"                                             "Y88P"  "
echo;                                                            
echo                                   Set hostname to wait for
set /p ip=
echo;
echo              Enter your email to alert yourself when the machine is online
echo;
set /p whois=
echo;
echo                    Enter a Job Title if you want for your own reference
echo;
set /p Jobno=
echo;
:Loop2
SET no2=1
echo;
echo This program is currently pinging %ip% and will send an email to %whois% when online.
echo;
PING %ip% -l 4 -n 2 | FIND "TTL=" > NUL
IF ERRORLEVEL 1 SET no2=0

if "%no2%" == "1" (
echo;
echo %ip% is now online mail shall now be sent to %whois%
echo;
swithMail.exe /s /from throwawayemail@gmail.com /pass Password /server smtp.gmail.com /p 587 /SSL /to %whois% /sub "Hostname Pinger :%ip% is now ONLINE %Jobno%" /b "The requested tracker was put inplace to alert yourself the next time %ip% was online. %Jobno% Courtesy of Percy's Hostname Alerter"
)


if "%no2%" == "0" (
PING %ip% -l 4 -n 2

timeout /t 30
GOTO loop2 )
