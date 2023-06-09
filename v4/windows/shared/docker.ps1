#GLOBALS
$packageName = "Docker Desktop"
$DockerInstallPath = "C:\Program Files\Docker\bin"

function InstallDocker {
    
        Write-Host "Trying to install or update Docker using Winget..."
        winget install $packageName -e
        Write-Host "Docker installed or updated successfully using Winget."

    }

function AddDockerToENV {
    # Get the current system PATH environment variable
    $currentPath = [Environment]::GetEnvironmentVariable('PATH', 'Machine')

    # Check if the Docker directory is already in the PATH
    if ($currentPath -split ';' -contains $DockerInstallPath) {
        Write-Host "Docker is already in the system PATH."
    }
    else {

        # Update the system PATH environment variable
        [Environment]::SetEnvironmentVariable("Path", "$env:Path;$DockerInstallPath", [EnvironmentVariableTarget]::User)
        Write-Host "Docker has been added to the system PATH."
    }
}


InstallDocker
#AddDockerToENV