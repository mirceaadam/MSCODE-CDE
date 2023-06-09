" "
" ....::: Enable Windows Features :::...."

# Windows Features for WSL
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

#RESTART REQUIRED
$input = Read-Host "Can I restart one last time? [Y]es / [N]o"
  if ($input -eq "Y") {
    "Restarting.."
    $flagFile = "C:\Temp\CDE\PerformedRestart.flag"
    New-Item -ItemType File -Path $flagFile -Force
    shutdown /r /t 0
    } else {
    "Don't forget to restart. WSL/Docker installation fails without restart."
    "Bye."