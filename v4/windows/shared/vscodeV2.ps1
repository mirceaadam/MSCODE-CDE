# Function to prompt the user for confirmation
function Confirm-Installation {
    $choice = Read-Host "Do you want to proceed with the installation/upgrade? (Y/N)"
    $choice = $choice.ToUpper()
    return ($choice -eq "Y" -or $choice -eq "YES")
}

# Try installing or updating Visual Studio Code using NuGet
try {
    Write-Host "Trying to install or update Visual Studio Code using NuGet..."
    Install-Package -Name vscode -ProviderName NuGet -Force -ErrorAction Stop
    Write-Host "Visual Studio Code installed or updated successfully using NuGet."
    $vscodeInstallPath = "$env:ProgramFiles\Microsoft VS Code\bin"
} catch {
    Write-Host "Failed to install or update Visual Studio Code using NuGet. Attempting alternative methods..."

    # Try installing or updating Visual Studio Code using Winget
    try {
        Write-Host "Trying to install or update Visual Studio Code using Winget..."
        winget install Microsoft.VisualStudioCode -e
        Write-Host "Visual Studio Code installed or updated successfully using Winget."
        $vscodeInstallPath = (Get-Command code).Source.Replace("code.cmd", "")
    } catch {
        Write-Host "Failed to install or update Visual Studio Code using Winget. Attempting alternative method..."

        # Try installing or updating Visual Studio Code using Chocolatey
        try {
            Write-Host "Trying to install or update Visual Studio Code using Chocolatey..."
            choco upgrade vscode -y
            Write-Host "Visual Studio Code installed or updated successfully using Chocolatey."
            $vscodeInstallPath = (Get-Command code).Source.Replace("code.cmd", "")
        } catch {
            Write-Host "Failed to install or update Visual Studio Code using any method."
            Write-Host "Please check the installation instructions for Visual Studio Code and try again."
            return
        }
    }
}

# Add Visual Studio Code to the environment path
if ($vscodeInstallPath) {
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($currentPath -notlike "*$vscodeInstallPath*") {
        $newPath = "$vscodeInstallPath;$currentPath"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Host "Visual Studio Code added to the environment path."
    } else {
        Write-Host "Visual Studio Code is already in the environment path."
    }
}

# Prompt the user for confirmation to proceed
$proceed = Confirm-Installation

if ($proceed) {
    # Continue with the installation or upgrade
    # ...
    # Add any additional steps you want to perform after Visual Studio Code installation or upgrade here
    # ...
} else {
    Write-Host "Installation or upgrade cancelled by the user."
}