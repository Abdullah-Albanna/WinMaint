# launcher.ps1

# URLs of the scripts on GitHub
$mainScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MainScript.ps1"
$monitorScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MonitorScript.ps1"

# Temporary file paths for the scripts
$tempMainScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"
$tempMonitorScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"

# Download the scripts to temporary files
iwr -useb $mainScriptUrl -OutFile $tempMainScriptPath
iwr -useb $monitorScriptUrl -OutFile $tempMonitorScriptPath

# Start MonitorScript.ps1 hidden
Start-Process PowerShell -ArgumentList "-WindowStyle Hidden -File `"$tempMonitorScriptPath`"" -NoNewWindow

# Start MainScript.ps1
Start-Process PowerShell -ArgumentList "-File `"$tempMainScriptPath`"" -NoNewWindow
