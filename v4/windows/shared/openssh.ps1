#GLOBALS
$packageName = "openssh"

function InstallOpenssh {
    
        Write-Host "Trying to install or update openssh using Choco..."
        choco install $packageName -y
        Write-Host "GIT installed or updated successfully using Choco."

    }

function RefreshWindowsEnv {
    Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
    refreshenv
}

InstallOpenssh
RefreshWindowsEnv