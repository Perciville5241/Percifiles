@echo on
::  Acknowledgements
::  [Github](https://github.com/Perciville5241) | [Twitter](https://twitter.com/Perciville5241) |  [Discord](Perciville#5241) |
::  :---: | :---: | :---: | :---: | :---: |

echo Merging all files

@ECHO OFF
ECHO Creating %1...
FOR /F "delims=" %%G IN ('DIR /B /a-d "*.dic"') DO (
ECHO Adding %%G
ECHO. >> Output.txt
for /f "usebackq tokens=*" %%a in ("%%~G") do (
Echo %%a >> Output.txt 
)
)

echo Cleaning up

::CLEANUP PROCESS

echo Removing null spaces

::Remove spaces

setlocal enableDelayedExpansion
set "spcs= "
for /l %%n in (1 1 12) do set "spcs=!spcs!!spcs!"
findstr /n "^" "Output.txt" >"Output.tmp"
setlocal disableDelayedExpansion
(
  for /f "usebackq delims=" %%L in ("Output.tmp") do (
    set "ln=%%L"
    setlocal enableDelayedExpansion
    set "ln=!ln:*:=!"
    set /a "n=4096"
    for /l %%i in (1 1 13) do (
      if defined ln for %%n in (!n!) do (
        if "!ln:~-%%n!"=="!spcs:~-%%n!" set "ln=!ln:~0,-%%n!"
        set /a "n/=2"
      )
    )
    echo(!ln!
    endlocal
  )
) >"Output.txt"
del "Output.tmp" 2>nul



Echo Removing empty lines

::EMPTY LINES

findstr /R . Output.txt>>Output2.txt
del Output.txt


Echo Ordering.

sort Output2.txt >>Output.txt
del Output2.txt
echo Remove Dupe's and null's

::Remove Duplicates

sort /C /UNIQUE "Output.txt" /O "Merged.txt"
del Output.txt

::Remove Unwanted
findstr /v /b /c:"FFFFFFFFFFFF" /c:"ffffffffffff" /c:"000000000000" /c:"a0a1a2a3a4a5" /c:"A0A1A2A3A4A5"  Merged.txt > OneBig.dic

del Merged.txt
