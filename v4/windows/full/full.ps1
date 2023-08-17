#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\shared"

function Render-Full {
    Write-Host " "
    Write-Host "     ... :: WSL Setup ::: ... "
    Write-Host "SETUP Will Install:   
                    Windows Subsystem For Linux (WSL)
                        |_wsl --install                 (REQUIRES RESTART)
                        |_WSL-Prep                  (optional: WillAskToInstall) 
                            |_awscli
                            |_getToken script
                            |_cdk, etc.
                            |_Docker in wsl                                           
                        VSCODE                      (optional: WillAskToInstall)
                        VSCODE-Extensions              (script:afterSetup)"                                               
}


function Render-FinalMessage {
    Write-Host "Install complete."
    Write-Host ""
    Write-Host "vscode has issues with env and extensions fail at 1st try."
    Write-Host "To fix that, run in an elevated powershell this command:"
    Write-Host " Start-Process Powershell $REPO_HOME\v4\common\extensions\extensions.ps1 -wait   "
}

function WSL-install {
    #INSTALL WSL
    #& $REPO_HOME\v4\windows\shared\wsl-custom.ps1
    & $REPO_HOME\v4\windows\shared\wsl-standard.ps1
}

function WSL-prep {
    Write-Host "Trigger WSL-prep ?"
    Write-Host "WSL-prep = use in WSL getToken, awscli, cdk, cfn-lint, codecommit, etc."
    $input_prep = Read-Host "Enter [y]es or [n]o:" 
        if ($input_prep -eq "y"){
            & $REPO_HOME\v4\windows\shared\wsl-prep.ps1
        } else {
            Write-Host "WSL-Prep Skipped."
            Write-Host "You can still trigger manually from: "
            Write-Host "/mnt/[$REPO_HOME]/v4/wsl/setup.sh"           
        }
}

function Docker-install {
    #INSTALL DOCKER with winget
    & $REPO_HOME\v4\windows\shared\docker.ps1
}

function Container-Prep {
    Write-Host "Trigger Container-Prep ?"
    Write-Host "Container-Prep = custom docker image with getToken, awscli, cdk, cfn-lint, codecommit, etc."
    $input_prep = Read-Host "Enter [y]es or [n]o:" 
        if ($input_prep -eq "y"){
            & $REPO_HOME\v4\windows\shared\container-prep.ps1
        } else {
            Write-Host "WSL-Prep Skipped."
            Write-Host "You can still trigger manually from: "
            Write-Host "/mnt/[$REPO_HOME]/v3/setup.sh"           
        }
}

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

function Perform-Restart{
#RESTART REQUIRED
clear
Write-Host "              ----                 "
Write-Host "...:: A restart is required. ::..."
Write-Host "              ----                 "
Write-Host "(!)-> Make sure to wait a few seconds after reboot for the WSL Install to Complete Fully!"
Write-Host "              ----                 "
Write-Host "(!)-> Provide a username and a password for WSL."
Write-Host "              ----                 "
Write-Host "                                   "
$input = Read-Host "Can I restart now ? (required) [y] / [n]"
  if ($input -eq "Y") {
    "Restarting.."
    $flagFile = "C:\Temp\CDE\PerformedRestart.flag"
    New-Item -ItemType File -Path $flagFile -Force
    shutdown /r /t 0
  } else {
    "Don't forget to restart. WSL and Docker installation fails without restart."
    "Bye."
  }
}

function VSCODE {
    #VSCODE
    Write-Host "Install VSCODE ?.."
    $input5 = Read-Host "Enter [y]es or [n]o:"
    if ($input5 -eq "y") {
        & $REPO_HOME\v4\windows\shared\vscode.ps1 
    } else {
        Write-Host "VSCODE Install skipped."
    }
}

# ----- START HERE --------
Render-Full
$flagFile = "C:\Temp\CDE\PerformedRestart.flag"
$flagExists = Check-Restart -FlagFile $flagFile
if ($flagExists) {
    Write-Host "Restart performed, resuming.."
    WSL-install
    WSL-prep
    #Docker-install
    Container-Prep
    VSCODE
    Render-FinalMessage
} else {
    Write-Host "Fresh Install detected - starting WSL installation..."
    #& $REPO_HOME\v4\windows\shared\win-features.ps1
    WSL-install
    Perform-Restart              
}