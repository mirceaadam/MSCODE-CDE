#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\shared"

function CheckScriptStatus {
    # Check if installation is already completed
    $completed = Get-ItemProperty -Path "HKCU:\Software\CDE" -Name "InstallationCompleted" -ErrorAction SilentlyContinue

    if ($completed -eq $null) {
        # Installation not completed, run the scripts in sequence
        & $REPO_HOME\v4\windows\full\sequences\1.ps1
        & $REPO_HOME\v4\windows\full\sequences\2.ps1
        & $REPO_HOME\v4\windows\full\sequences\3.ps1

        # Set a registry key to indicate that the installation is completed
        New-ItemProperty -Path "HKCU:\Software\CDE" -Name "InstallationCompleted" -Value 1 -PropertyType DWORD
    } else {
        # Installation already completed, do nothing
        Write-Host "Installation already completed."
    }
}


function Render-Full {
    Write-Host " "
    Write-Host "     ... :: Full Setup ::: ... "
    Write-Host " Full Contains:
                    - BASE: Win:Features, Kernel , WSL, Ubuntu:latest
                    - VSCODE (ask: optional)
                    - VSCODE-Extensions (ask: optional)
                    - Docker (ask: optional)
                    - WSL-Prep (ask: optional)
                    - Container-Prep (ask: optional) "               
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
$selectedOption = Read-Host " Begin Installation ? [y]es or [n]o"

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
}
else {
    switch ($selectedOption.ToLower()) {
        "y" {
            CheckScriptStatus
            Render-FinalMessage
        }
        "n" {
            Exit
        }
    }
}



