:: This script automates the proccess of deleting the "SoftwareDistribution" folder if the MainScript.ps1 failed/froze/the user closed it before finishing
:: as that would cause the "Getting Windows ready" message when restarting to get stuck!

@echo off
 SETLOCAL ENABLEDELAYEDEXPANSION

:loop
REM Check if powershell.exe is running
tasklist /FI "IMAGENAME eq powershell.exe" 2>NUL | find /I /N "powershell.exe">NUL
if "%ERRORLEVEL%"=="0" (
    REM powershell.exe is running
    timeout /t 5 /nobreak >NUL
    goto loop
) else (
    REM powershell.exe is not running, check the log file
    set "logfile=C:\Users\%username%\AppData\Local\Temp\LogFile.txt"
    echo Checking logfile: !logfile!
    if exist "!logfile!" (
        set "found=0"
        for /F "delims=" %%i in ('type "!logfile!" ^| findstr /C:"Maintenance completed. Please restart the computer"') do set found=1
        if "!found!"=="0" (
            REM The specified line is not found in the log file, executing commands
            net stop wuauserv
            net stop bits
            rmdir /s /q C:\Windows\SoftwareDistribution
            net start wuauserv
            net start bits
        )
    ) else (
        echo Log file not found: !logfile!
    )
)
echo Script finished.
