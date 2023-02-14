#Script to install python, pip and git-commit-helper

#GLOBALS
$INSTALL_DIR = 'C:\Temp\tools'
$USER = $env:UserName
$local_pip_helper_installer = "$INSTALL_DIR\tools.ps1"

#Get new version here: https://www.python.org/ftp/python/
$python_url  = 'https://www.python.org/ftp/python/3.10.10/python-3.10.10-amd64.exe'
$local_python_installer = "$INSTALL_DIR\python-installer-amd64.exe"
$PYTHON_VERSION = 'Python310'
$PYTHON_PATH = "C:\Users\$USER\AppData\Local\Programs\Python\$PYTHON_VERSION\"
$PYTHON_PATH_SCRIPTS = "C:\Users\$USER\AppData\Local\Programs\Python\$PYTHON_VERSION\Scripts\" 

#Get new version here: https://github.com/git-for-windows/git/releases
$git_url  = 'https://github.com/git-for-windows/git/releases/download/v2.39.1.windows.1/Git-2.39.1-64-bit.exe'
$local_git_installer = "$INSTALL_DIR\git-installer.exe"

clear
"Hi! This will install: "
"	- git (silent install)"
"	- python 3.10.10 (as of 07 Feb 2023) (silent install)"
" 	- pip"
"	- git-remote-codecommit (needs pip & git)"

#------ git Download & INSTALLATION ---------
"Ready?.."
" "
"Press Y to start git installation."
"OR" 
"Press N to SKIP. (if you have git already installed)"
" "
$input = Read-Host "Enter Y or N , CTRL+C to exit."
# Check the input and branch based on the result
if ($input -eq "Y") {
            # Do something if the input is "Y"
            Write-Host "You entered Y, starting to download..."
            "Fething the defined version of GIT (it could take a while - DO NOT CLOSE this powershell window)"
            $currentTime = Get-Date
                # Time the execution of a command
                $ElapsedTime = Measure-Command {
                    # The command to be timed goes here
                    $wc = New-Object net.webclient
                    $wc.Downloadfile($git_url, $local_git_installer)
                }
            
            # Get the total elapsed time in minutes
            $TotalMinutes = $ElapsedTime.TotalMinutes
            
            # Display the elapsed time in minutes
            "Finished Download, Elapsed time: $TotalMinutes minutes"
            " "
			" "
			"Installing git: Will take a while.."
			" "
            "!!! DO NOT CLOSE THIS WINDOW !!!"
            Start-Process $local_git_installer -ArgumentList "/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS=icons,ext\shellhere /NOICONS" -Wait
			" "
			clear
			"DONE. git installed.."
			" "
			"Cleaning up after myself.."
			rm $local_git_installer
} else {
			"git install skipped."		
}

#------ PYTHON Download & INSTALLATION ---------
"Press Y to start python installation."
"OR" 
"Press N to exit"
" "
$input = Read-Host "Enter Y or N, CTRL+C to exit."
# Check the input and branch based on the result
if ($input -eq "Y") {
            # Do something if the input is "Y"
            Write-Host "You entered Y, starting to download..."
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
            # C:\Users\mircea.adam\AppData\Local\Programs\Python\Python310\Scripts\
            # C:\Users\mircea.adam\AppData\Local\Programs\Python\Python310\
            
            $pathValue = "$PYTHON_PATH"

            if ($env:Path -notlike "*$pathValue*") {
                $env:Path += ";$PYTHON_PATH;$PYTHON_PATH_SCRIPTS"
                [Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::User)
            }

            # "Fix for python specific app execution aliases.."
            # # Get the policy for the AppExecutionAlias value
            # $AppExecutionPolicy = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun"

            # # Check if the policy exists
            # if ($AppExecutionPolicy) {
            #     # Check if the Python app execution alias is already disabled
            #     if ($AppExecutionPolicy.DisallowRun -notlike "*.py") {
            #         # Add the Python app execution alias to the policy
            #         $AppExecutionPolicy.DisallowRun = "$($AppExecutionPolicy.DisallowRun);*.py"
            #         Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -Value $AppExecutionPolicy.DisallowRun
            #         Write-Output "App execution alias for Python has been disabled."
            #     } else {
            #         Write-Output "App execution alias for Python is already disabled."
            #     }
            # } else {
            #     # Create the policy and add the Python app execution alias
            #     New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -PropertyType String -Value "*.py"
            #     Write-Output "App execution alias for Python has been disabled."
            # }
            
            "Installing the rest of tools in a separate window...(because windows..)"
			Start-Process Powershell $local_pip_helper_installer -wait	
			
			"Cleaning up after myself.."
			rm $local_python_installer 

			"Done. You can close this window. Have fun!"
			$input = Read-Host "Install complete, just press ANY Key.."
			break
			
			
} else {
			"Ok, Bye."
            break		
}
