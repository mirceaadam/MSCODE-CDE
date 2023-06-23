#GLOBALS
$packageName = "Git.Git"
$GitInstallPath1 = "C:\Program Files\Git\bin"
$GitInstallPath2 = "C:\Program Files\Git\cmd"
$script_location = 'C:\Temp\CDE\Update-SessionEnvironment.ps1'

function InstallGit {
    
        Write-Host "Trying to install or update GIT using Winget..."
        winget install $packageName -e
        Write-Host "GIT installed or updated successfully using Winget."

    }

function AddGitToENV {
    # Get the current system PATH environment variable
    $currentPath = [Environment]::GetEnvironmentVariable('PATH', 'Machine')

    # Check if the GIT directory is already in the PATH
    if ($currentPath -split ';' -contains $GitInstallPath) {
        Write-Host "GIT is already in the system PATH."
    }
    else {

        # Update the system PATH environment variable
        [Environment]::SetEnvironmentVariable("Path", "$env:Path;$GitInstallPath1", [EnvironmentVariableTarget]::User)
        [Environment]::SetEnvironmentVariable("Path", "$env:Path;$GitInstallPath2", [EnvironmentVariableTarget]::User)
        Write-Host "GIT has been added to the system PATH."
    }
}

function RefreshWindowsEnv {
    Start-Process PowerShell $script_location -wait
}

InstallGit
AddGitToENV
RefreshWindowsEnv