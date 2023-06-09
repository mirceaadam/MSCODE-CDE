# DEVOPS WIN ENV v4.0

#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\shared"
$MinimalSetup = "$REPO_HOME\v4\windows\minimal\minimal.ps1"
$FullSetup = "$REPO_HOME\v4\windows\full\full.ps1"


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
function PacketManagers {
    Write-Host "Setup is checking local package managers.."
    # & $PacketManagersFolder\choco.ps1
    # & $PacketManagersFolder\winget.ps1

    $scripts = Get-ChildItem -Path $PacketManagersFolder -Filter "*.ps1" | Sort-Object

    foreach ($script in $scripts) {
        Write-Host "Running script: $($script.Name)"
        & $script.FullName
        Write-Host "Script completed: $($script.Name)`n"
    }
}

# Ask what to install: minimal or full or update
function Show-Help {
    Write-Host "(!)Usage -You have to actually type a setup option."
    Write-Host "  - minimal: awscli + mfa (mandatory), python+pip+code-commit-helper (optional)"
    Write-Host "  - full: WSL full configuration + MSCODE + Docker(optional) + minimal setup (optional) "
    Write-Host "  - update: //under construction: Will check and update Docker + MSCODE + python + git (and update)"
    Write-Host "TYPE for example: minimal or full or update"
}

function Show-MinimalSetup {
    Write-Host "[ minimal ]"
    Write-Host "- awscli"
    Write-Host "- awscli MFA: getToken (script) + add to Environment Variables"
    Write-Host "- Microsoft Code (vscode) (optional)"
    Write-Host "- Microsoft Code (vscode) Extensions (optional)"
    Write-Host "- git (optional)"
    Write-Host "- code-commit-helper (optional)"
    Write-Host "- Python.Python.3.8 (required to install code-commit-helper)"
    Write-Host "- pip (required to install code-commit-helper)"
    Write-Host "- cfn-lint (optional)"
}

function Show-FullSetup {
    Write-Host "[ full ]"
    Write-Host "- Minimal Setup (optional)"
    Write-Host "- Windows Settings to enable WSL Properly"
    Write-Host "- Windows Kernel Update for WSL"
    Write-Host "- WSL + Ubuntu:latest"
    Write-Host "- Microsoft Code (vscode)"
    Write-Host "- Microsoft Code (vscode) Extensions"
    Write-Host "- Docker: latest (optional)"
}

function Show-UpdateSetup {
    Write-Host "[ update ]"
    Write-Host "//under construction: Will check and update Docker + MSCODE + python + git (and update)"
}

function Render-Meniu {
    Write-Host "..::: Welcome to Windows Custom Development Environment version 4.0 ::.."
    Write-Host "THE SETUP OPTIONS ARE:"
    Show-MinimalSetup
    Show-FullSetup
    Show-UpdateSetup
}

$validOptions = @("minimal", "full", "update")

Render-Meniu
$selectedOption = Read-Host "Type Exactly the word for what setup type you would like - [ minimal ] or [ full ] or [ update ]"

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
}
else {
    switch ($selectedOption.ToLower()) {
        "minimal" {
            PacketManagers
            & $MinimalSetup
            
        }
        "full" {
            PacketManagers
            & $FullSetup
        }
        "update" {
            PacketManagers
            Show-UpdateSetup
        }
    }
}



