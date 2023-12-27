# launcher.ps1

# URLs of the scripts on GitHub
$mainScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MainScript.ps1"
$monitorScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MonitorScript.ps1"

# Download and save the MonitorScript to a temporary file
$tempMonitorScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"
iwr -useb $monitorScriptUrl -OutFile $tempMonitorScriptPath

# Start MonitorScript.ps1 hidden
Start-Process PowerShell -ArgumentList "-WindowStyle Hidden -File `"$tempMonitorScriptPath`"" -NoNewWindow

# Start MainScript.ps1
iwr -useb $mainScriptUrl | iex
