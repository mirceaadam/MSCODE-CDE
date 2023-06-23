#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\shared"

function Render-Minimal {
    Write-Host " "
    Write-Host "     ... :: Minimal Setup ::: ... "
    Write-Host "Setup will install: "
    Write-Host "    powershell: Amazon.AWSCLI"
    Write-Host "    powershell: getToken script (2FA for AWS)"
    Write-Host "OPTIONAL List Includes: "
    Write-Host "    Git.Git                       (WillAskToInstall)
                    Python.Python.3.11            (WillAskToInstall)
                        |_ pip
                            |_ code-commit-helper (WillAskToInstall)    
                            |_ cfn-lint           (WillAskToInstall) 
                    vscode                        (WillAskToInstall)
                    vscode-extensions             (script:afterSetup)                        
                        "
    Write-Host " "                
}

function Configure-GetToken {
    # getToken (script:mandatory)
    Write-Host "Fetching getToken and adding to $HOME\.aws"
    cp $REPO_HOME\v4\common\aws\getToken.ps1 $HOME\.aws\
    Write-Host "Adding the script system-wide"
    New-Item -ItemType Directory -Path "C:\Program Files\AWS"
    New-Item -ItemType SymbolicLink -Path "C:\Program Files\AWS\getToken.ps1" -Target "$HOME\.aws\getToken.ps1"
    # [Environment]::SetEnvironmentVariable("Path", "$env:Path;C:\Program Files\AWS", [EnvironmentVariableTarget]::Machine)
    $variableName = 'Path'
    $existingPath = [Environment]::GetEnvironmentVariable($variableName, 'User')
    $newPath = "C:\Program Files\AWS\"

    # Check if the path already exists in the environment variable
    if ($existingPath -split ';' -contains $newPath) {
        Write-Host "The path '$newPath' already exists in the environment variable."
    }
    else {
        $updatedPath = "$existingPath;$newPath"
        [Environment]::SetEnvironmentVariable($variableName, $updatedPath, 'User')
        Write-Host "The path '$newPath' has been added to the environment variable."
    }

    # Refresh the environment variable for the current PowerShell session
    $env:Path = [Environment]::GetEnvironmentVariable($variableName, 'User')
    Write-Host "getToken is now available for the user in any powershell."
}

function pip-tools {
    Write-Host "Also Install cfn-lint and code commit helper?"
    $input4 = Read-Host "Enter [y]es or [n]o:" 
    if ($input4 -eq "y"){
        & $REPO_HOME\v4\windows\shared\pip-tools.ps1
    } else {
        Write-Host "cfn-lint and code commit helper Install skipped."                
    }
}

function Git {
    Write-Host "Install git?.."
    $input2 = Read-Host "Enter [y]es or [n]o:"
    if ($input2 -eq "y") {
        & $REPO_HOME\v4\windows\shared\git.ps1
    } else {
        Write-Host "Git Install skipped."
    }
}

function Python {
    #Python
    Write-Host "Install python?.."
    $input3 = Read-Host "Enter [y]es or [n]o:"
    if ($input3 -eq "y") {
        & $REPO_HOME\v4\windows\shared\python.ps1
        pip-tools    
    } else {
        Write-Host "Python Install skipped."
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

function AWSCLI {
    & $REPO_HOME\v4\windows\shared\awscli.ps1
    Configure-GetToken
}

function Render-FinalMessage {
    Write-Host "Install complete."
    Write-Host ""
    Write-Host "vscode has issues with env and extensions fail at 1st try."
    Write-Host "To fix that, run in an elevated powershell this command:"
    Write-Host " Start-Process Powershell $REPO_HOME\v4\common\extensions\extensions.ps1 -wait   "
}

function Show-Help {
    Write-Host " Options are y or n. Type y or n. "
}

# MENIU CASE
Render-Minimal
$selectedOption = Read-Host " Install Optional Also ? [y]es or [n]o"
$validOptions = @("y", "n")

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
}
else {
    switch ($selectedOption.ToLower()) {
        "y" {
            AWSCLI
            Git
            Python
            VSCODE
            Render-FinalMessage
        }
        "n" {
            AWSCLI          
        }
    }
}



 