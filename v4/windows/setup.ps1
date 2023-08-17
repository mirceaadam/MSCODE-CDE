# DEVOPS WIN ENV v4.1

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
    #new!
    clear
    Write-Host "The directory '$AWS' does not exist. Follow instructions below."
    & $REPO_HOME\v4\common\aws\awsCredentialsConfigurator.ps1
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
    Write-Host "(!) Usage - You have to actually type a setup option."
    Write-Host "Check: https://github.com/mirceaadam/MSCODE-CDE/blob/main/media/setup.png"
    Write-Host "TYPE for example: 'win' or 'wsl' or 'continue'"
    Pause
    & $REPO_HOME\v4\windows\setup.ps1
}

function Show-MinimalSetup {
    Write-Host " "
    Write-Host "[ win ] - windows only - no restart "
    Write-Host "- mandatory: awscli + getToken (MFA script)"
    Write-Host "- optional: Microsoft Code + git + Python.Python.3.8 + pip + code-commit-helper + cfn-lint"
    Write-Host " "
}

function Show-FullSetup {
    Write-Host " "
    Write-Host "[ wsl ] - 1 restart "
    Write-Host "- mandatory: WSL"
    Write-Host "- optional: WSL Customization with gettoken and all software [incl. git, pip, Docker (latest) inside wsl,etc. ] + Microsoft Code"
    Write-Host " "
}

function Show-UpdateSetup {
    Write-Host " "
    Write-Host "[ continue ]"
    Write-Host "Not available yet, work in progress, continue from a wsl --install reboot."
    Write-Host " "
}

function Render-Meniu {
    clear
    Write-Host "..::: Welcome to Windows Custom Development Environment version 4.5 ::.."
    Write-Host "THE SETUP OPTIONS available here: https://github.com/mirceaadam/MSCODE-CDE"
    Show-MinimalSetup
    Show-FullSetup
    Show-UpdateSetup
}

$validOptions = @("win", "wsl", "continue")

Render-Meniu
$selectedOption = Read-Host "Type Exactly the word for what setup type you would like - [ win ] or [ wsl ] or [ continue ]"

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
    Render-Meniu
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



