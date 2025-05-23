#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\shared"

function Render-Minimal {
    clear
    Write-Host " "
    Write-Host "     ... :: PowerShell Windows Setup :: ... "
    Write-Host "SOFTWARE:"
    Write-Host "     [STANDARD] awscli"
    Write-Host "     [STANDARD] getToken powershell script"
    Write-Host "     [STANDARD] GitLab: openSSH"
    Write-Host "     [STANDARD] GitLab: Auto Generate key"
    Write-Host " "
    Write-Host "     [OPTIONAL] Git"                    
    Write-Host "     [OPTIONAL] Python.3.13"          
    Write-Host "                     |- pip "
    Write-Host "                         |- code-commit-helper"   
    Write-Host "                         |- cfn-lint "         
    Write-Host "     [OPTIONAL] vscode"
    Write-Host "     [OPTIONAL] vscode-extensions"
    Write-Host " "
    Write-Host "   ... :: You can skip any software you want :: ..."                            
    Write-Host " "
                    
} 


function Configure-Credentials {
    & $REPO_HOME\v4\common\aws\awsCredentialsConfigurator.ps1
}
function Configure-GetToken {
    # getToken (script:mandatory)
    Write-Host "Fetching getToken and adding to $HOME\.aws"
    cp $REPO_HOME\v4\common\aws\getTokenV2.ps1 $HOME\.aws\
    Write-Host "Adding the script system-wide"
    New-Item -ItemType Directory -Path "C:\Program Files\AWS"
    New-Item -ItemType SymbolicLink -Path "C:\Program Files\AWS\getToken.ps1" -Target "$HOME\.aws\getTokenV2.ps1"
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

function OpenSSH {
    Write-Host "Install openSSH (for GitLab key Access)?.."
    $input2 = Read-Host "Enter [y]es or [n]o:"
    if ($input2 -eq "y") {
        & $REPO_HOME\v4\windows\shared\openssh.ps1
    } else {
        Write-Host "openSSH Install skipped."
    }
}

function GenerateSSHKey {
    Write-Host "Would you like to also generate the GitLab key Access ?.."
    $input2 = Read-Host "Enter [y]es or [n]o:"
    if ($input2 -eq "y") {
        & $REPO_HOME\v4\windows\shared\gitlabAccess.ps1
    } else {
        Write-Host "Auto Key Gen skipped."
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
    Configure-Credentials
    Configure-GetToken
}

function Render-FinalMessage {
    Write-Host " "
    Write-Host "P.S: if you want some vscode extensions, use this command:"
    Write-Host " Start-Process Powershell $REPO_HOME\v4\common\extensions\extensions.ps1 -wait   "    
    Write-Host " "
    Write-Host "     --- Happy coding, THANK YOU FOR USING MY SCRIPT ---   "
    Write-Host " "
}

function Show-Help {
    Write-Host " Options are y or n. Type y or n. "
}

# MENIU CASE
Render-Minimal
$selectedOption = Read-Host " Install OPTIONAL Also ? [y]es or [n]o"
$validOptions = @("y", "n")

if (-not $validOptions.Contains($selectedOption.ToLower())) {
    Show-Help
}
else {
    switch ($selectedOption.ToLower()) {
        "y" {
            AWSCLI            
            Python
            Git            
            OpenSSH
            GenerateSSHKey
            VSCODE
            Render-FinalMessage
        }
        "n" {
            AWSCLI 
            OpenSSH
            GenerateSSHKey         
        }
    }
}



 