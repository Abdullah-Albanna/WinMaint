# MonitorScript.ps1

$mainScriptName = "MainScript.ps1"
$logPath = "C:\LogFile.txt"

# Function to check if the main script is still running
function Is-ScriptRunning {
    param($scriptName)
    return Get-Process PowerShell | Where-Object { $_.MainWindowTitle -like "*$scriptName*" }
}

# Function to check the log for successful completion
function Is-LogComplete {
    param($logPath)
    # Implement logic to check if the log indicates successful completion
    # ...
}

# Function for cleanup actions
function PerformCleanup {
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
}

# Monitoring loop
while ($true) {
    if (-not (Is-ScriptRunning -scriptName $mainScriptName)) {
        # Main script is not running. Check if it completed successfully.
        if (-not (Is-LogComplete -logPath $logPath)) {
            # Log indicates unsuccessful completion. Perform cleanup.
            PerformCleanup
        }
        break
    }
    Start-Sleep -Seconds 3  # Check every 3 seconds
}
