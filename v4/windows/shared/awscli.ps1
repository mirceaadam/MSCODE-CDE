#GLOBALS
$packageName = "Amazon.AWSCLI"
$awsCliInstallPath = "C:\Program Files\Amazon\AWSCLIV2"

function InstallUpdateAwsCli {
    
# Try installing or updating AWS CLI using NuGet
try {
    Write-Host "Trying to install or update AWS CLI using NuGet..."
    Install-Package -Name AWSPowerShell.NetCore -ProviderName NuGet -Force -ErrorAction Stop
    Write-Host "AWS CLI installed or updated successfully using NuGet."
} catch {
    Write-Host "Failed to install or update AWS CLI using NuGet. Attempting alternative methods..."

    # Try installing or updating AWS CLI using Winget
    try {
        Write-Host "Trying to install or update AWS CLI using Winget..."
        winget install Amazon.AWSCLI -e
        Write-Host "AWS CLI installed or updated successfully using Winget."
    } catch {
        Write-Host "Failed to install or update AWS CLI using Winget. Attempting alternative method..."

        # Try installing or updating AWS CLI using Chocolatey
        try {
            Write-Host "Trying to install or update AWS CLI using Chocolatey..."
            choco upgrade awscli -y
            Write-Host "AWS CLI installed or updated successfully using Chocolatey."
        } catch {
            Write-Host "Failed to install or update AWS CLI using any method."
            Write-Host "Please check the installation instructions for AWS CLI and try again."
        }
    }
}
}

function AddAwsCliToENV {
# Set the installation directory of the Amazon AWS CLI


# Get the current system PATH environment variable
$currentPath = [Environment]::GetEnvironmentVariable('PATH', 'Machine')

# Check if the AWS CLI directory is already in the PATH
if ($currentPath -split ';' -contains $awsCliInstallPath) {
    Write-Host "AWS CLI is already in the system PATH."
}
else {
    # Append the AWS CLI directory to the PATH
    $newPath = $currentPath + ";" + $awsCliInstallPath

    # Update the system PATH environment variable
    [Environment]::SetEnvironmentVariable('PATH', $newPath, 'Machine')

    Write-Host "AWS CLI has been added to the system PATH."
}
}

InstallUpdateAwsCli
AddAwsCliToENV