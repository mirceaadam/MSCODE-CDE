#Mircea Adam - 04 Ian 2023

# Important Variables
# Set the path to the script that you want to run
$ScriptPath = "C:\Temp\devops\2.ps1"
$TaskName = "devopsEnvironmentInstaller"
$TaskCommand = "powershell.exe -File `"$ScriptPath`""
$local_getToken_script = 'C:\Temp\devops\getToken.ps1'
$local_aws_credentials = 'C:\Temp\devops\.aws'

# Create the scheduled task
"Creating Scheduled Task OnRestart.."
schtasks /Create /SC ONLOGON /TN $TaskName /TR $TaskCommand /RL HIGHEST

" "
"Let's configure AWS Locally."
$input3 = Read-Host "Configure AWS in Powershell? [Y](yes) or [N](no)"
if ($input3 -eq "Y") {
                mkdir $env:USERPROFILE\.aws
                cp -v $local_getToken_script $env:USERPROFILE\.aws\
                cp -v $local_aws_credentials\* $env:USERPROFILE\.aws\
				"You have to use the documentation to run this further."
    } else { 
        "OK."
}


# Windows Features for WSL
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
#RESTART REQUIRED
shutdown /r /t 0