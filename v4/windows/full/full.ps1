#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\shared"

function Render-Full {
    Write-Host " "
    Write-Host "     ... :: Full Setup ::: ... "
    Write-Host "Setup Will Install:
                    VSCODE                              (stable release)
                    VSCODE-Extensions                   (script:afterSetup)    
                    Windows Subsystem For Linux (WSL)
                        |_Enable Windows Features        (req. restart!)
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

function Show-Help {
    Write-Host " Options are y or n. Type y or n. "
}

function Render-FinalMessage {
    Write-Host "Install complete."
    Write-Host ""
    Write-Host "vscode has issues with env and extensions fail at 1st try."
    Write-Host "To fix that, run in an elevated powershell this command:"
    Write-Host " Start-Process Powershell $REPO_HOME\v4\common\extensions\extensions.ps1 -wait   "
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
            & $REPO_HOME\v4\windows\shared\win-features.ps1
            Render-FinalMessage
        }
        "n" {
            Exit
        }
    }
}



