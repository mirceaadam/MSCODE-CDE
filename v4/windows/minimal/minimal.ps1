#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\shared"

function Render-Minimal {
    Write-Host " "
    Write-Host "     ... :: Minimal Setup ::: ... "
    Write-Host " "
    Write-Host "Mandatory: "
    Write-Host "    Amazon.AWSCLI (winget:mandatory)"
    Write-Host "    $HOME/.aws/getToken.ps1 (script:mandatory) + added in ENV"
    Write-Host "Optional: "
    Write-Host "    Python.Python.3.11 (winget:optional)
                    Git.Git (winget:optional)
                    vscode (winget:optional)
                    vscode-extensions (script:optional)
                    code-commit-helper (script:optional)    
                    cfn-lint (script:optional) "
    Write-Host " "                
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

function Configure-GetToken {
    # getToken (script:mandatory)
    Write-Host "Fetching getToken and adding to $HOME\.aws"
    cp $REPO_HOME\v4\common\aws\getToken.ps1 $HOME\.aws\
    Write-Host "Adding the script system-wide"
    New-Item -ItemType Directory -Path "C:\Program Files\AWS"
    New-Item -ItemType SymbolicLink -Path "C:\Program Files\AWS\getToken.ps1" -Target "$HOME\.aws\getToken.ps1"
    [Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\Program Files\AWS", [EnvironmentVariableTarget]::Machine)
    Write-Host "getToken is now available system-wide."
}


$validOptions = @("y", "n")

Render-Minimal
$selectedOption = Read-Host " Install Optional? [y]es or [n]o"

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
}
else {
    switch ($selectedOption.ToLower()) {
        "y" {
            & $REPO_HOME\v4\windows\shared\awscli.ps1
            & $REPO_HOME\v4\windows\shared\python.ps1
            & $REPO_HOME\v4\windows\shared\git.ps1
            & $REPO_HOME\v4\windows\shared\pip-tools.ps1
            & $REPO_HOME\v4\windows\shared\vscode.ps1
            #& $REPO_HOME\v4\common\extensions\extensions.ps1
            Configure-GetToken
            Render-FinalMessage
        }
        "n" {
            & $REPO_HOME\v4\windows\shared\awscli.ps1
            Configure-GetToken          
        }
    }
}



 