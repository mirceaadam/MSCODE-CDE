# DEVOPS WIN ENV v4.0

#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName


# ESENTIAL CHECKS
if (Test-Path -Path $REPO_HOME -PathType Container) {
    Write-Host "The directory '$REPO_HOME' exists."
}
else {
    Write-Host "The directory '$REPO_HOME' does not exist."
    Exit
}

if (Test-Path -Path $AWS -PathType Container) {
    Write-Host "The directory '$AWS' exists."
}
else {
    Write-Host "The directory '$AWS' does not exist. Make sure you configure it first."
    Exit
}

# PACKAGE MANAGERS CHECK
Write-Host "Setup is checking local package managers.."
$scriptFolder = "$REPO_HOME\v4\windows\packet-manager"  # Replace with the path to your script folder

$scripts = Get-ChildItem -Path $scriptFolder -Filter "*.ps1" | Sort-Object

foreach ($script in $scripts) {
    Write-Host "Running script: $($script.Name)"
    & $script.FullName
    Write-Host "Script completed: $($script.Name)`n"
}

# Ask what to install: minimal or full or update
function Show-Help {
    Write-Host "Usage: Choose a setup option:"
    Write-Host "  - minimal: Displays minimal setup information."
    Write-Host "  - full: Displays full setup information."
    Write-Host "  - update: Displays update information for existing installation."
    Write-Host ""
    Write-Host "Example: .\setup.ps1 full"
}

function Show-MinimalSetup {
    Write-Host "Minimal Setup:"
    Write-Host "- awscli"
    Write-Host "- awscli MFA: getToken (script) + add to Environment Variables"
    Write-Host "- git (optional)"
    Write-Host "- code-commit-helper (optional)"
    Write-Host "- Python.Python.3.8 (required to install code-commit-helper)"
    Write-Host "- pip (required to install code-commit-helper)"
}

function Show-FullSetup {
    Write-Host "Full Setup:"
    Write-Host "- Minimal Setup (optional)"
    Write-Host "- Windows Settings to enable WSL Properly"
    Write-Host "- Windows Kernel Update for WSL"
    Write-Host "- WSL + Ubuntu:latest"
    Write-Host "- Microsoft Code"
    Write-Host "- Microsoft Code Extensions"
    Write-Host "- Docker: latest (optional)"
}

$validOptions = @("minimal", "full", "update")

$selectedOption = Read-Host "Choose a setup option (minimal, full, update):"

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
}
else {
    switch ($selectedOption.ToLower()) {
        "minimal" {
            Show-MinimalSetup
        }
        "full" {
            Show-FullSetup
        }
        "update" {
            Write-Host "Update information for existing installation."
        }
    }
}



