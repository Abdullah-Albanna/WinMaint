# Set the console window title
[Console]::Title = "Abdullah Albanna"

# Define the path for logging in the Windows Temp folder
$logPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "LogFile.txt")

# Check if the log file exists, and delete it if it does
if (Test-Path $logPath) {
    Remove-Item -Path $logPath -Force
}

# Start logging
Start-Transcript -Path $logPath -Append

# Change PowerShell background color to Black
$originalBgColor = $Host.UI.RawUI.BackgroundColor
$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host  # Refresh the console with the new background color

# Check for administrative privileges
$isAdmin = [bool]((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
if (-not $isAdmin) {
    Write-Host "This script requires administrative privileges." -ForegroundColor Red
    Write-Host "Please run it as an administrator." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit..." -ForegroundColor Gray
    exit 1
}

Start-Sleep -Milliseconds 500

# Resetting Windows Update Components
# Write-Host "Resetting Windows Update Components..." -ForegroundColor Green
# Start-Sleep -Milliseconds 500

# Stop Windows Update service (wuauserv) and BITS service
# Stop-Service -Name wuauserv -Force
# Stop-Service -Name bits -Force

# Delete files in SoftwareDistribution
# Remove-Item -Path "C:\Windows\SoftwareDistribution\*" -Force -Recurse

# Start Windows Update service (wuauserv) and BITS service
# Start-Service -Name wuauserv
# Start-Service -Name bits

# Start-Sleep -Milliseconds 500

# Repair the Windows image by downloading replacement files from Windows Update.
Write-Host "Repairing the Windows image..." -ForegroundColor Blue
Start-Sleep -Milliseconds 500
DISM /Online /Cleanup-Image /RestoreHealth

# Clean up the component store to reduce the size of the WinSxS folder.
Write-Host "Cleaning up the component store..." -ForegroundColor DarkCyan
Start-Sleep -Milliseconds 500
DISM /Online /Cleanup-Image /StartComponentCleanup

# Scan and repair corrupted or missing system files.
Write-Host "Scanning and repairing corrupted or missing system files..." -ForegroundColor Cyan
Start-Sleep -Milliseconds 500
sfc /scannow

# Scan and repair file system errors and bad sectors on an external drive with the drive letter "C:"
Write-Host "Scanning and repairing file system errors on drive C:..." -ForegroundColor Yellow
Start-Sleep -Milliseconds 500
echo Y | chkdsk /f /r C:

Start-Sleep -Milliseconds 500
Write-Host ""
Write-Host "Maintenance completed. Please restart the computer" -ForegroundColor Green
Write-Host "Press any key to exit..."
Start-Sleep -Milliseconds 2000

# Wait for any key press
[Console]::ReadKey() > $null

# Stop logging
Stop-Transcript

# Revert PowerShell background color to original
$Host.UI.RawUI.BackgroundColor = $originalBgColor
Clear-Host

# Forcefully terminate the PowerShell process
[System.Environment]::Exit(0)
