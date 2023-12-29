Start-Process -NoNewWindow powershell.exe -ArgumentList "-File .\MainScript.ps1"
Start-Process cmd.exe -ArgumentList "/c MonitorScript.cmd" -WindowStyle Hidden