# launcher.ps1

# URLs of the scripts on GitHub
$mainScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MainScript.ps1"
$monitorScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MonitorScript.ps1"

# Download and execute MainScript.ps1 from GitHub
iwr -useb $mainScriptUrl | iex

# Download MonitorScript.ps1 and execute it hidden
$monitorScriptContent = iwr -useb $monitorScriptUrl
Start-Process PowerShell -ArgumentList "-WindowStyle Hidden -Command $monitorScriptContent" -NoNewWindow
