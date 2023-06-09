#GLOBALS
$packageName = "Amazon.AWSCLI"
$awsCliInstallPath = "C:\Program Files\Amazon\AWSCLIV2"

function InstallAwsCli {
    
        Write-Host "Trying to install or update AWS CLI using Winget..."
        winget install $packageName -e
        Write-Host "AWS CLI installed or updated successfully using Winget."

    }

function AddAwsCliToENV {

# Get the current system PATH environment variable
$currentPath = [Environment]::GetEnvironmentVariable('PATH', 'Machine')

# Check if the AWS CLI directory is already in the PATH
if ($currentPath -split ';' -contains $awsCliInstallPath) {
    Write-Host "AWS CLI is already in the system PATH."
}
else {

    # Update the system PATH environment variable
    [Environment]::SetEnvironmentVariable("Path", "$env:Path;$awsCliInstallPath", [EnvironmentVariableTarget]::User)
    Write-Host "AWS CLI has been added to the system PATH."
}
}

function Configure-GetToken {
    # getToken (script:mandatory)
    Write-Host "Fetching getToken and adding to $HOME\.aws"
    cp $REPO_HOME\v4\common\aws\getToken.ps1 $HOME\.aws\
    Write-Host "Adding the script system-wide"
    New-Item -ItemType Directory -Path "C:\Program Files\AWS"
    New-Item -ItemType SymbolicLink -Path "C:\Program Files\AWS\getToken.ps1" -Target "$HOME\.aws\getToken.ps1"
    [Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\Program Files\AWS", [EnvironmentVariableTarget]::User)
    Write-Host "getToken is now available system-wide."
}

InstallAwsCli
AddAwsCliToENV
Configure-GetToken