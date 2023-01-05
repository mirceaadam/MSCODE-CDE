#Mircea Adam - 04 Ian 2023

# Important Variables
# Set the path to the script that you want to run
$ScriptPath = "C:\Temp\devops\2.ps1"
$TaskName = "devopsEnvironmentInstaller"
$TaskCommand = "powershell.exe -File `"$ScriptPath`""

# Create the scheduled task
"Creating Scheduled Task OnRestart.."
schtasks /Create /SC ONLOGON /TN $TaskName /TR $TaskCommand /RL HIGHEST

# Windows Features for WSL
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
#RESTART REQUIRED
shutdown /r /t 0