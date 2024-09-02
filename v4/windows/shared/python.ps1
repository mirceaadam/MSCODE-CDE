#chco failed
#winget failed
#Script to install python, pip and git-commit-helper

# GLOBALS
$INSTALL_DIR = 'C:\Temp\CDE'
$REPO_HOME = 'C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main'
$USER = $env:UserName
$local_pip_helper_installer = "$REPO_HOME\v4\windows\managers\optional\pip.ps1"

# PYTHON VERSION
# ---> Get new version here: https://www.python.org/ftp/python/
$python_url  = 'https://www.python.org/ftp/python/3.12.4/python-3.11.4-amd64.exe'
$PYTHON_VERSION = 'Python312'
$local_python_installer = "$INSTALL_DIR\python-installer-amd64.exe"
$PYTHON_PATH = "C:\Users\$USER\AppData\Local\Programs\Python\$PYTHON_VERSION\"
$PYTHON_PATH_SCRIPTS = "C:\Users\$USER\AppData\Local\Programs\Python\$PYTHON_VERSION\Scripts\"

"Hi! This will install: "
"	- $PYTHON_VERSION (silent install)"
" 	- pip"

#------ PYTHON Download & INSTALLATION ---------
"Fething the defined PYTHON Image (it could take a while - DO NOT CLOSE this powershell window)"
$currentTime = Get-Date
    # Time the execution of a command
    $ElapsedTime = Measure-Command {
        # The command to be timed goes here
        $wc = New-Object net.webclient
        $wc.Downloadfile($python_url, $local_python_installer)
    }

# Get the total elapsed time in minutes
$TotalMinutes = $ElapsedTime.TotalMinutes

# Display the elapsed time in minutes
"Finished Download, Elapsed time: $TotalMinutes minutes"
" "
" "
"Installing Python..."
" "
"!!! DO NOT CLOSE THIS WINDOW !!!"
Start-Process $local_python_installer -ArgumentList "/quiet InstallAllUsers=0" -Wait

"Setting up Environment Variables for python in case it does not exist.."

$pathValue = "$PYTHON_PATH"

if ($env:Path -notlike "*$pathValue*") {
    $env:Path += ";$PYTHON_PATH;$PYTHON_PATH_SCRIPTS"
    [Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::User)
}

function RefreshWindowsEnv {
    Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
    refreshenv
}

"Installing the rest of tools in a separate window...(because windows..)"
Start-Process Powershell $local_pip_helper_installer -wait	

"Cleaning up after myself.."
rm $local_python_installer

"Refreshing Windows Env"
RefreshWindowsEnv
			
			

