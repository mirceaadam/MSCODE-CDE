#GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$AWS = "$HOME\.aws"
$USER = $env:UserName
$PacketManagersFolder = "$REPO_HOME\v4\windows\managers\mandatory"

Write-Host " ....::: Installing MSCode Extensions :::...."
Get-Content "$REPO_HOME\v4\common\extensions\extensions.txt" | ForEach-Object { code --install-extension $_ }