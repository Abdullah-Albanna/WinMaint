$cmdScriptUrl = "https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MonitorScript.cmd"
$cmdScriptPath = "$env:TEMP\GithubTempFile.cmd"
Invoke-WebRequest -Uri $cmdScriptUrl -OutFile $cmdScriptPath
#Start-Process cmd.exe -ArgumentList "/c $cmdScriptPath" -WindowStyle Hidden
#iwr -useb https://raw.githubusercontent.com/Abdullah-Albanna/WinMaint/main/MainScript.ps1 | iex
