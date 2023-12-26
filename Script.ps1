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

# Display messages and perform tasks with a half-second delay before each task
Write-Host "The script has administrative privileges." -ForegroundColor Green
Start-Sleep -Milliseconds 500

# Repair the Windows image by downloading replacement files from Windows Update.
Write-Host "Repairing the Windows image..." -ForegroundColor Blue
Start-Sleep -Milliseconds 500
DISM /Online /Cleanup-Image /RestoreHealth

# Clean up the component store to reduce the size of the WinSxS folder.
Write-Host "Cleaning up the component store..." -ForegroundColor DarkCyan
Start-Sleep -Milliseconds 500
DISM /Online /Cleanup-Image /StartComponentCleanup

# Scan and repair corrupted or missing system files. Useful for addressing Windows errors and stability issues.
Write-Host "Scanning and repairing corrupted or missing system files..." -ForegroundColor DarkYellow
Start-Sleep -Milliseconds 500
sfc /scannow

# Scan and repair file system errors and bad sectors on an external drive with the drive letter "C:"
Write-Host "Scanning and repairing file system errors on drive C:..." -ForegroundColor DarkGreen
Start-Sleep -Milliseconds 500
echo Y | chkdsk /f /r C:

Write-Host ""
Write-Host "Maintenance completed." -ForegroundColor Green
Read-Host "Press Enter to exit..." -ForegroundColor Gray

# Revert PowerShell background color to original
$Host.UI.RawUI.BackgroundColor = $originalBgColor
Clear-Host
