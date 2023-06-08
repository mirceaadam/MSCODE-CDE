#This script continues to install the devops environment with docker containers.
$local_ubuntu_installer = 'C:\Temp\Ubuntu.appx'
$local_kernel_installer = 'C:\Temp\wsl_update_x64.msi'
$local_mscode_installer = 'C:\Temp\VSCodeUserSetup-x64.exe'
$local_docker_installer = 'C:\Temp\DockerDesktopInstaller.exe'
$docker_executable = "C:\Program Files\Docker\Docker\Docker Desktop.exe"

" "
" ....::: DevOps Container Setup Part II :::...."
" "
"Starting Docker.. Follow instructions in the wizard"
Start-Process $docker_executable
" "
"Cleaning up everything."
remove-item -Path $local_ubuntu_installer -Force 
remove-item -Path $local_kernel_installer -Force
remove-item -Path $local_mscode_installer -Force
remove-item -Path $local_docker_installer -Force
" "
"Again, I am removing myself from ScheduledTasks.. "
$TaskName2 = "devopsEnvironmentInstaller2"
schtasks /delete /tn $TaskName2 /F 2>$null
" "
"Good day."