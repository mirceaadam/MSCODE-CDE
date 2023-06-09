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

InstallAwsCli
AddAwsCliToENV
