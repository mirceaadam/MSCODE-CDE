#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$USER = $env:UserName
#idea: use user.settings maybe ?
Write-Host "Triggering.."
cd $REPO_HOME\v4\wsl
wsl -e bash ./trigger.sh