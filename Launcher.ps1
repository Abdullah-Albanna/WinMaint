# launcher.ps1

# URLs of the scripts on GitHub
$mainScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MainScript.ps1"
$monitorScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MonitorScript.ps1"

# Download the scripts and store them as script blocks
$mainScriptBlock = [ScriptBlock]::Create((iwr -useb $mainScriptUrl).Content)
$monitorScriptBlock = [ScriptBlock]::Create((iwr -useb $monitorScriptUrl).Content)

# Start the MonitorScript as a background job (hidden)
Start-Job -ScriptBlock $monitorScriptBlock

# Execute the MainScript
& $mainScriptBlock
