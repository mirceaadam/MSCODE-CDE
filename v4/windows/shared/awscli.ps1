#GLOBALS
$packageName = "Amazon.AWSCLI"
$awsCliInstallPath = "C:\Program Files\Amazon\AWSCLIV2"
$script_location = 'C:\Temp\CDE\Update-SessionEnvironment.ps1'

function InstallAwsCli {
    
        Write-Host "Trying to install or update AWS CLI using msiexec..."
        
        # Download and install the AWS CLI MSI installer for Windows (64-bit)
        Invoke-WebRequest -Uri https://awscli.amazonaws.com/AWSCLIV2.msi -OutFile 'C:\Temp\AWSCLI.msi'
        
        #msiexec.exe /i 'C:\Temp\AWSCLI.msi' /qn
        #/qn option is not installing correctly across the system :(
        msiexec.exe /i 'C:\Temp\AWSCLI.msi'
        Write-Host "AWS CLI installed or updated successfully using msiexec."
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
    $variableName = 'Path'
    $existingPath = [Environment]::GetEnvironmentVariable($variableName, 'User')
    $newPath = "$awsCliInstallPath"
    # Check if the path already exists in the environment variable
    if ($existingPath -split ';' -contains $newPath) {
        Write-Host "The path '$newPath' already exists in the environment variable."
    }
    else {
        $updatedPath = "$existingPath;$newPath"
        [Environment]::SetEnvironmentVariable($variableName, $updatedPath, 'User')
        Write-Host "The path '$newPath' has been added to the environment variable."
    }

    # Refresh the environment variable for the current PowerShell session
    $env:Path = [Environment]::GetEnvironmentVariable($variableName, 'User')
    Write-Host "AWS CLI has been added to the system PATH."
}
}

function RefreshWindowsEnv {
    Start-Process PowerShell $script_location -wait
}

InstallAwsCli
AddAwsCliToENV
RefreshWindowsEnv
