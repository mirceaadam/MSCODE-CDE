#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\managers\mandatory"

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

function Install-Mandatory-WinGet {
    $MandatoryPackagesFile = "$REPO_HOME\v4\windows\minimal\install_mandatory.txt"

    # Read the package names from the file
    $packageNames = Get-Content -Path $MandatoryPackagesFile

    # Process each package
    foreach ($packageName in $packageNames) {
            # Install the package using Winget
            Write-Host "Installing $packageName using Winget..."
            winget install $packageName -e
    }
}

function Install-Optional-WinGet {
    $OptionalPackagesFile = "$REPO_HOME\v4\windows\minimal\install_optional.txt"

    # Read the package names from the file
    $packageNames = Get-Content -Path $OptionalPackagesFile

    # Process each package
    foreach ($packageName in $packageNames) {
            # Install the package using Winget
            Write-Host "Installing $packageName using Winget..."
            winget install $packageName -e
    }
}

function Install-Mandatory-Script {
    # getToken (script:mandatory)
    cp $REPO_HOME\v4\common\aws\getToken.ps1 $HOME\.aws\
}

function Install-Optional-Script {
    #vscode-extensions (script:optional)
    $install_extensions = "$REPO_HOME\v4\common\extensions\extensions.ps1"
    & $install_extensions
    #code-commit-helper (command:optional)
    pip install git-remote-codecommit    
    #cfn-lint (command:optional)
    pip install cfn-lint     
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
            Install-Mandatory-WinGet
            Install-Mandatory-Script
            & $REPO_HOME\v4\windows\managers\optional\python-pip.ps1
            Install-Optional-WinGet
            Install-Optional-Script

        }
        "n" {
            Install-Mandatory-WinGet
            Install-Mandatory-Script
        }
    }
}



 