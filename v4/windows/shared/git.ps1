# Function to prompt the user for confirmation
function Confirm-Installation {
    $choice = Read-Host "Do you want to proceed with the installation/upgrade of git? (Y/N)"
    $choice = $choice.ToUpper()
    return ($choice -eq "Y" -or $choice -eq "YES")
}

# Try installing or updating Git using NuGet
try {
    Write-Host "Trying to install or update Git using NuGet..."
    Install-Package -Name git -ProviderName NuGet -Force -ErrorAction Stop
    Write-Host "Git installed or updated successfully using NuGet."
    $gitInstallPath = "$env:ProgramFiles\Git\cmd"
} catch {
    Write-Host "Failed to install or update Git using NuGet. Attempting alternative methods..."

    # Try installing or updating Git using Winget
    try {
        Write-Host "Trying to install or update Git using Winget..."
        winget install Git -e
        Write-Host "Git installed or updated successfully using Winget."
        $gitInstallPath = (Get-Command git).Source.Replace("git.exe", "")
    } catch {
        Write-Host "Failed to install or update Git using Winget. Attempting alternative method..."

        # Try installing or updating Git using Chocolatey
        try {
            Write-Host "Trying to install or update Git using Chocolatey..."
            choco upgrade git -y
            Write-Host "Git installed or updated successfully using Chocolatey."
            $gitInstallPath = (Get-Command git).Source.Replace("git.exe", "")
        } catch {
            Write-Host "Failed to install or update Git using any method."
            Write-Host "Please check the installation instructions for Git and try again."
            return
        }
    }
}

# Add Git to the environment path
if ($gitInstallPath) {
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($currentPath -notlike "*$gitInstallPath*") {
        $newPath = "$gitInstallPath;$currentPath"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Host "Git added to the environment path."
    } else {
        Write-Host "Git is already in the environment path."
    }
}

# Prompt the user for confirmation to proceed
$proceed = Confirm-Installation

if ($proceed) {
    # Continue with the installation or upgrade
    # ...
    # Add any additional steps you want to perform after Git installation or upgrade here
    # ...
} else {
    Write-Host "Installation or upgrade cancelled by the user."
}
