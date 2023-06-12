#GLOBALS
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
Write-Host "Triggering.."
cd $REPO_HOME\v4\wsl
wsl -e bash ./trigger.sh