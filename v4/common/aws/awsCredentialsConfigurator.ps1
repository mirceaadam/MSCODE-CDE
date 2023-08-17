#GLOBALS
$AWS = "$HOME\.aws"
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'


function CheckAWS{
    Write-Host " "
    Write-Host " Checking for .aws folder for current user."

    $awsFolderPath = Join-Path $env:USERPROFILE ".aws"

    if (-not (Test-Path -Path $awsFolderPath -PathType Container)) {
        Write-Host "Folder $awsFolderPath NOT FOUND !"
    } 
    else {
        Write-Host "Well done!"
        Write-Host "Folder '$awsFolderPath' already exists => Nothing to do."
        Pause
        exit
    }
    
}

function Options{
    $validOptions = @("retry", "create", "help")
    $selectedOption = Read-Host "Type the Options you want - [ retry / create / help ]:"
    if (-not $validOptions.Contains($selectedOption.ToLower())) {
        help
    }
    else {
        switch ($selectedOption.ToLower()) {
            "retry" {
                Write-Host "Retrying..."
                clear
                & $REPO_HOME\v4\common\aws\awsCredentialsConfigurator.ps1
            }
            "create" {
                Write-Host "Creating Example AWS Creds"
                clear
                createExampleCreds
            }
            "help" {
                Write-Host "Help:"
                clear
                Help
            }
        }
    }
}

function createExampleCreds{
    Write-Host " "
    Write-Host " Copying an example aws credentials/config files for current user. "
    mkdir $AWS
    cp -v $REPO_HOME\v4\common\.aws-example\* $AWS\
    ConfigSupport
    Pause
    exit
}
function Help{
    Write-Host "This setup is for configuring your local credentials and config file which should normally exist here: $AWS"
    Write-Host "This configuration is mandatory in order for your aws cli to work for your organization you are part of."
    Write-Host "Click this link for details: https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-help.html"
    Write-Host " -----------------------------------------------SCENARIOS----------------------------------------------------"
    Write-Host " -> [SCENARIO 1] <- FIRST time use: just let the setup [ create ] a template for you and you can edit later."
    Write-Host " -> [SCENARIO 2] <- $AWS exists => just ignore or you can [ retry ] if you forgot them."
    Write-Host " ------------------------------------------------------------------------------------------------------------"
    Pause
    & $REPO_HOME\v4\common\aws\awsCredentialsConfigurator.ps1
}

function ConfigSupport{
    Write-Host "NEXT:"
    Write-Host " - Contact an AWS Accounts Administrator."
    Write-Host " - $AWS\credentials: modify lines 2+3 and 6+7"
    Write-Host " - $AWS\config: for just one profile modify lines 5+6+7+8"
    Write-Host "Press any key to continue..."
    Pause
}

function Meniu {
    Write-Host " Hi $env:USERNAME !"
    Write-Host " -----------------------------------------------(!)(!)(!)----------------------------------------------------"
    Write-Host " -> [SCENARIO 1] <- FIRST time use: just let the setup  [ create ] a template for you and you can edit later."
    Write-Host " -> [SCENARIO 2] <- $AWS exists => just ignore or you can [ retry ] if you forgot them."
    Write-Host " -----------------------------------------------(!)(!)(!)----------------------------------------------------"
}

# ------------START--------
CheckAWS
Meniu
Options  