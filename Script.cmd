@echo off

:: Check for administrative privileges
whoami /groups | find "S-1-16-12288" > nul
if %errorlevel% neq 0 (
    echo This script requires administrative privileges.
    echo Please run it as an administrator.
    echo.
    pause
    exit /b 1
)

:: Display messages and perform tasks with a half-second delay before each task
echo The script has administrative privileges.
ping -n 1 -w 500 > nul

:: Repair the Windows image by downloading replacement files from Windows Update.
echo Repairing the Windows image...
ping -n 1 -w 500 > nul
dism /online /cleanup-image /restorehealth

:: Clean up the component store to reduce the size of the WinSxS folder.
echo Cleaning up the component store...
ping -n 1 -w 500 > nul
DISM /Online /Cleanup-Image /StartComponentCleanup

:: Scan and repair corrupted or missing system files. Useful for addressing Windows errors and stability issues.
echo Scanning and repairing corrupted or missing system files...
ping -n 1 -w 500 > nul
sfc /scannow

:: Scan and repair file system errors and bad sectors on an external drive with the drive letter "C:"
echo Scanning and repairing file system errors on drive C:...
ping -n 1 -w 500 > nul
(echo Y) | chkdsk /f /r C:

echo.
echo Maintenance completed.
echo Press any key to exit...
pause > nul
