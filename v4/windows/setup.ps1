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

#check restart
function Check-Restart {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript({Test-Path $_ -PathType 'Leaf'})]
        [string]$FlagFile
    )

    if (Test-Path $FlagFile -PathType 'Leaf') {
        return $true
    } else {
        return $false
    }
}

# PACKAGE MANAGERS CHECK
function PacketManagers {
    Write-Host "Setup is checking local package managers.."
    & $PacketManagersFolder\choco.ps1
    & $PacketManagersFolder\winget.ps1
    Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
    refreshenv
    #& $PacketManagersFolder\win-refresh-env.ps1
}

# Ask what to install: minimal or full or continue
function Show-Help {
    clear
    Write-Host "(!)Usage -You have to actually type a setup option."
    Write-Host "Check: https://github.com/mirceaadam/MSCODE-CDE/blob/main/media/setup.png"
    Write-Host "TYPE for example: win or wsl or continue"
}

function Show-MinimalSetup {
    Write-Host "[ win ] - windows only - no restart "
    Write-Host "- awscli"
    Write-Host "- awscli MFA: getToken (script) + add to Environment Variables"
    Write-Host "- Microsoft Code (vscode) (optional)"
    Write-Host "- Microsoft Code (vscode) Extensions (optional)"
    Write-Host "- git (optional / ask to install )"
    Write-Host "- Python.Python.3.8 (required to install code-commit-helper)"
    Write-Host "-   pip (required to install code-commit-helper)"
    Write-Host "-       code-commit-helper (optional)"    
    Write-Host "-       cfn-lint (optional)"
}

function Show-FullSetup {
    Write-Host "[ wsl ] - 2 restarts "
    Write-Host "- Windows Settings to enable WSL Properly"
    Write-Host "- Windows Kernel Update for WSL"
    Write-Host "- WSL + Ubuntu:latest"
    Write-Host "- Microsoft Code (vscode)"
    Write-Host "- Microsoft Code (vscode) Extensions"
    Write-Host "- Docker: latest (optional / ask to be installed)"
    Write-Host "- Minimal Setup (if you need powershell cli access)"
}

function Show-UpdateSetup {
    Write-Host "[ continue ]"
    Write-Host "Not available yet, work in progress, continue from a wsl --install reboot."
}

function Render-Meniu {
    clear
    Write-Host "..::: Welcome to Windows Custom Development Environment version 4.0 ::.."
    Write-Host "THE SETUP OPTIONS available here: https://github.com/mirceaadam/MSCODE-CDE/blob/main/media/setup.png"
    Show-MinimalSetup
    Show-FullSetup
    Show-UpdateSetup
}

$validOptions = @("win", "wsl", "continue")

Render-Meniu
$selectedOption = Read-Host "Type Exactly the word for what setup type you would like - [ win ] or [ wsl ] or [ continue ]"

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
}
else {
    switch ($selectedOption.ToLower()) {
        "win" {
            clear
            PacketManagers
            & $MinimalSetup
            
        }
        "wsl" {
            clear
            PacketManagers
            & $FullSetup
        }
        "continue" {
            clear
            PacketManagers
            Show-UpdateSetup
        }
    }
}



