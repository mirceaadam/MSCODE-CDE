#Mircea Adam - 04 Ian 2023

# Important Variables
$ProgressPreference = 'SilentlyContinue'

# Windows Features for WSL
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
#RESTART REQUIRED
shutdown /r /t 0