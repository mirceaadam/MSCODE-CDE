#GLOBALS
$docker_url = 'https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe'
$local_docker_installer = 'C:\Temp\DockerDesktopInstaller.exe'

function InstallDocker {
    "Proceed with next step?"
    "Complete WSL installation from the prompts."
    $input2 = Read-Host "Ready to install Docker? [Y](yes) or [N](no)"
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
    }        