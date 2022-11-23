::a command line for text to speech to another machine using PSEXEC


echo text to voice
Set /p Whattosay=
echo set ip
set /p ip=
echo PowerShell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('%Whattosay%');" >speakman.bat
psexec.exe \\%ip% -C speakman.bat
pause
