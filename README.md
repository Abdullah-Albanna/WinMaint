## What is this?
**WinMaint**, pronounced ***Windows Maintenance***, is just a simple script that I use when Windows starts being weired or some features does not work, apps not opening/working.

I usually use it just to make Windows feel ***FRESH***

## What does it do?
 * Repairs corrupted Windows files by downloading them and replace them
 * Cleans up the component store to reduce the size of the WinSxS folder
 * Scans and repairs corrupted or missing system files
 * Scans and repairs file system errors and bad sectors in the drive "C"

## Usage
 * Hold Win + R
 * Type in `powershell`, hit enter while holding Shift + Ctrl, this will open it up as an Administrator
 * copy the command and paste it in PowerShell

          iwr -useb https://is.gd/WinMaint | iex
 * Make sure to restart after that as it will also checks the disks for errors, and that should be it!

## Troubleshooing
 * The script frezzes at the starts:
   - Restart the computer
   - If that's not working then you need to enter this command into the CMD as an Administrator, and restart the computer:
          
          net stop wuauserv & net stop bits & del /f /s /q C:\Windows\SoftwareDistribution\*.* & net start wuauserv & net start bits
     what it does is basiclly stops the Windows updates and deletes pending updates, and enables the Windows updates again
