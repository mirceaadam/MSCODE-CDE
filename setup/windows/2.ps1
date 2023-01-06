#2
# WE INSTALL MSCODE + KERNEL UPDATE for WSL + UBUNTU
$ubuntu_url = 'https://aka.ms/wslubuntu2204'
$kernel_update_url = 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'
$mscode_url = 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user'
$docker_url = 'https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe'

$local_ubuntu_installer = 'C:\Temp\Ubuntu.appx'
$local_kernel_installer = 'C:\Temp\wsl_update_x64.msi'
$local_mscode_installer = 'C:\Temp\VSCodeUserSetup-x64.exe'
$local_docker_installer = 'C:\Temp\DockerDesktopInstaller.exe'

$TaskName = "devopsEnvironmentInstaller"
" "
"Hello! If you see this window, I have revived myself after reboot"
"So, I am removing myself from ScheduledTasks.."
schtasks /delete /tn $TaskName /F 2>$null
" "
" ....::: DevOps Container Setup Part I :::...."
"Let's begin."
" "

# Create the scheduled task
# "Creating Scheduled Task OnRestart.."
# $TaskName2 = "devopsEnvironmentInstaller2"
# $TaskCommand = "powershell.exe -File `"$ScriptPath`""
# $ScriptPath = "C:\Temp\devops\3.ps1"
# schtasks /Create /SC ONLOGON /TN $TaskName2 /TR $TaskCommand /RL HIGHEST

#------ MSCODE INSTALLATION ---------
"Fetching the latest version of MSCODE.."
$ElapsedTime = Measure-Command {
  # The command to be timed goes here
  $wc = New-Object net.webclient
  $wc.Downloadfile($mscode_url, $local_mscode_installer)
}
# Get the total elapsed time in minutes
$TotalMinutes = $ElapsedTime.TotalMinutes
# Display the elapsed time in minutes
"Finished Download, Elapsed time: $TotalMinutes minutes"
#Start-Process PowerShell $local_mscode_installer -wait
"Installing mscode, do not close this window, please wait.."
Start-Process $local_mscode_installer /VERYSILENT -NoNewWindow -Wait -PassThru

#------ KERNEL UPDATE INSTALLATION ---------
"Fetching the kernel update.."
$ElapsedTime = Measure-Command {
  # The command to be timed goes here
  $wc = New-Object net.webclient
  $wc.Downloadfile($kernel_update_url, $local_kernel_installer)
}
# Get the total elapsed time in minutes
$TotalMinutes = $ElapsedTime.TotalMinutes
# Display the elapsed time in minutes
"Finished Download, Elapsed time: $TotalMinutes minutes"
"Installing kernel update, do not close this windows, please wait.."
# Wait for the MSI installer to finish
Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/i $local_kernel_installer /qn" -wait

#------ UBUNTU Download & INSTALLATION ---------
" " 
"Ubuntu Takes aprox 9.1 minutes to fetch from the internet     -> Y"
"Or make sure you have copied C:\Temp\Ubuntu.appx already      -> N or ANY Key"
" "
"Press Y to fetch from the internet."
"OR" 
"Press N to fetch Locally (default)."
" "
$input = Read-Host "Enter Y or N"

# Check the input and branch based on the result
if ($input -eq "Y") {
            # Do something if the input is "Y"
            Write-Host "You entered Y, good luck waiting."
            "Fething the defined Ubuntu Image (~1Gb, it could take a while - DO NOT CLOSE this powershell window)"
            $currentTime = Get-Date
            "Windows is windows so do not expect any fancy progress bar, instead I can tell you.. started the download at: $currentTime"
            "...please wait around 9.1 minutes."
                # Time the execution of a command
                $ElapsedTime = Measure-Command {
                    # The command to be timed goes here
                    $wc = New-Object net.webclient
                    $wc.Downloadfile($ubuntu_url, $local_ubuntu_installer)
                }
            
            # Get the total elapsed time in minutes
            $TotalMinutes = $ElapsedTime.TotalMinutes
            
            # Display the elapsed time in minutes
            "Finished Download, Elapsed time: $TotalMinutes minutes"
            " "
            "When prompted, Hit LAUNCH and install ubuntu. DO NOT CLOSE THIS WINDOW."
            "Provide a username/password when prompted and DO NOT LOSE IT !"
            wsl --set-default-version 2
            Add-AppxPackage $local_ubuntu_installer
            Start-Process PowerShell $local_ubuntu_installer -wait  
} else {
            # Do something if the input is not "Y"
            Write-Host "Wise choice, Fetching Locally.."
            wsl --set-default-version 2
            Add-AppxPackage $local_ubuntu_installer
            " "
            "When prompted, Hit LAUNCH and install ubuntu. DO NOT CLOSE THIS WINDOW."
            "Provide a username/password when prompted and DO NOT LOSE IT !"            
            Start-Process PowerShell $local_ubuntu_installer -wait
}

" "
"Proceed with next step?"
$input2 = Read-Host "Install Docker? [Y](yes) or [N](no)"
if ($input2 -eq "Y") {
                # Time the execution of a command
                $ElapsedTime = Measure-Command {
                    # The command to be timed goes here
                    $wc = New-Object net.webclient
                    $wc.Downloadfile($docker_url, $local_docker_installer)
                }
            
                # Get the total elapsed time in minutes
                $TotalMinutes = $ElapsedTime.TotalMinutes
                
                # Display the elapsed time in minutes
                "Finished Download, Elapsed time: $TotalMinutes minutes"
                #Start-Process PowerShell $local_docker_installer -wait
				"Installing docker, do not close this window, please wait.."
				Start-Process $local_docker_installer "install --quiet" -Wait -NoNewWindow -PassThru
    } else { 
        "OK, not installing Docker."
    }

"::Please Check::"        
"Tools have been installed. "
"For perfect results, a restart is highly recommended."
"If the final script does not Start automatically, start Docker using the 3rd script after restart."

$input3 = Read-Host "Can I restart one last time? [Y]es / [N]o"
  if ($input2 -eq "Y") {
    "Restarting.."
    shutdown /r /t 0
    } else {
    "Don't forget to just start Docker manually after a restart."
    "Bye."
  }






