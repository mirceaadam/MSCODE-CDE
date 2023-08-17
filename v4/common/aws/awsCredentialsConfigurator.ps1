#GLOBALS
$AWS = "$HOME\.aws"
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'


function CheckAWS{
    Write-Host " "
    Write-Host "AWS CREDENTIAL CONFIGURATOR:"

    $awsFolderPath = Join-Path $env:USERPROFILE ".aws"

    if (-not (Test-Path -Path $awsFolderPath -PathType Container)) {
        Write-Host "Folder $awsFolderPath NOT FOUND !"
    } 
    else {
        Write-Host "Well done!"
        Write-Host "Found '$awsFolderPath' already configured."
        Pause
        exit
    }
    
}

function Options{
    $validOptions = @("retry", "ignore", "help")
    $selectedOption = Read-Host "Type the Options you want - [ retry / ignore / help ]:"
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
            "ignore" {
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
    cp $REPO_HOME\v4\common\.aws-example\* $AWS\
    ConfigSupport
    exit
}
function Help{
    clear
    Write-Host "This setup is for configuring your local credentials and config file which should normally exist here: $AWS"
    Write-Host "The Example credentials profided as a template (if you don't already have one), are compatible with getToken script and awsume."
    Write-Host "This configuration is mandatory in order for your aws cli to work for your organization you are part of."
    Write-Host "Click this link for details: https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-help.html"
    Write-Host " ---------------------------------------------------------SCENARIOS----------------------------------------------------------------"
    Write-Host " -> [SCENARIO 1] <- FIRST time use: just type [ ignore ] and the setup will create a dummy template for you and you can edit later."
    Write-Host " -> [SCENARIO 2] <- ALERADY have a '.aws' folder => COPY IT NOW to $env:USERPROFILE and type [ retry ] here."
    Write-Host " ----------------------------------------------------------------------------------------------------------------------------------"
    Pause
    & $REPO_HOME\v4\common\aws\awsCredentialsConfigurator.ps1
}

function ConfigSupport{
    Write-Host "NEXT, you need to:"
    Write-Host " - Contact an AWS Accounts Administrator."
    Write-Host " - open '$AWS\credentials': MODIFY lines 2+3, 6+7 and 13+16"
    Write-Host " - open '$AWS\config': for just one profile, MODIFY lines 5+6+7+8"
    Pause
}

function Meniu {
    Write-Host " Hi $env:USERNAME !"
    Write-Host " -----------------------------------------------(!)(!)(!)--------------------------------------------------------------------------"
    Write-Host " -> [SCENARIO 1] <- FIRST time use: just type [ ignore ] and the setup will create a dummy template for you and you can edit later."
    Write-Host " -> [SCENARIO 2] <- ALERADY have a '.aws' folder => COPY IT NOW to $env:USERPROFILE and type [ retry ] here."
    Write-Host " -----------------------------------------------(!)(!)(!)--------------------------------------------------------------------------"
}

# ------------START--------
clear
CheckAWS
Meniu
Options  