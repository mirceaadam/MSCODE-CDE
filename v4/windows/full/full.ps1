#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\shared"

function Render-Full {
    Write-Host " "
    Write-Host "     ... :: Full Setup ::: ... "
    Write-Host "SETUP Will Install:
                    VSCODE                               (stable release)
                    VSCODE-Extensions                   (script:afterSetup)    
                    Windows Subsystem For Linux (WSL)
                        |_Enable Windows Features       (REQUIRES RESTART)
                        |_Kernel+WSL+Ubuntu             (latest available)
                        |_WSL-Prep                      (WillAskToInstall) 
                            |_awscli
                            |_getToken
                            |_cdk, etc.                                          
                OPTIONAL List Includes:                 (   OPTIONAL    )
                        AWS DEV CONTAINER               
                            |_Docker                    (WillAskToInstall)
                            |_Container-Prep            (WillAskToInstall) 
                                |_awscli
                                |_getToken
                                |_cdk, etc. "               
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

function Show-Help {
    Write-Host " Options are y or n. Type y or n. "
}

$validOptions = @("y", "n")

Render-Full
$selectedOption = Read-Host " Install Optional (incl. AWS Dev Containers) as well ? [y]es or [n]o"

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
}
else {
    switch ($selectedOption.ToLower()) {
        "y" {
            VSCODE
            $flagFile = "C:\Temp\CDE\PerformedRestart.flag"
            $flagExists = Check-Restart -FlagFile $flagFile
            if ($flagExists) {
                Write-Host "Restart performed, resuming.."
                WSL-install
                WSL-prep
                #Docker-install
                Container-Prep                
                Render-FinalMessage
            } else {
                Write-Host "Fresh Install detected, Enable Windows Features..."
                & $REPO_HOME\v4\windows\shared\win-features.ps1                
            }
        }
        "n" {
            VSCODE
            $flagFile = "C:\Temp\CDE\PerformedRestart.flag"
            $flagExists = Check-Restart -FlagFile $flagFile
            if ($flagExists) {
                Write-Host "Restart performed, resuming.."
                WSL-install
                WSL-prep
                Render-FinalMessage
            } else {
                Write-Host "Fresh Install detected, Enable Windows Features..."
                & $REPO_HOME\v4\windows\shared\win-features.ps1                
            }            
        }
    }
}



