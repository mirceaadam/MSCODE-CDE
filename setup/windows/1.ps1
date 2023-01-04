dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
#RESTART REQUIRED
shutdown /r /t 0
wsl --set-default-version 2
wsl –update
wsl –install -d ubuntu
mkdir C:\temp\devops
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2204 -OutFile C:\temp\devops\Ubuntu.appx -UseBasicParsing #!takes too long
wget https://aka.ms/wslubuntu2204
Add-AppxPackage C:\temp\devopsUbuntu.appx