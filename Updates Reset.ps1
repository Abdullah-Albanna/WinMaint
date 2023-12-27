# Resetting Windows Update Components
Write-Host "Resetting Windows Update Components..." -ForegroundColor Green
Start-Sleep -Milliseconds 500

# Check if Windows Update service is running and stop it if it is
$wuauserv = Get-Service -Name wuauserv
$wuauservRunning = $false
if ($wuauserv.Status -eq 'Running') {
    $wuauservRunning = $true
    Stop-Service -Name wuauserv
}

# Check if BITS service is running and stop it if it is
$bits = Get-Service -Name bits
$bitsRunning = $false
if ($bits.Status -eq 'Running') {
    $bitsRunning = $true
    Stop-Service -Name bits
}

# Delete files in SoftwareDistribution
Remove-Item -Path "C:\Windows\SoftwareDistribution\*" -Force -Recurse

# Start services if they were originally running
if ($wuauservRunning) {
    Start-Service -Name wuauserv
}
if ($bitsRunning) {
    Start-Service -Name bits
}
