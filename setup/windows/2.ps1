#2
# WE INSTALL MSCODE + KERNEL UPDATE for WSL + UBUNTU
$ubuntu_url = 'https://aka.ms/wslubuntu2204'
$kernel_update_url = 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'
$mscode_url = 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user'

$local_ubuntu_location = 'C:\temp\Ubuntu.appx'
$local_kernel_installer = 'C:\temp\wsl_update_x64.msi'
$local_mscode_installer = 'C:\temp\VSCodeUserSetup-x64.exe'



#------ MSCODE INSTALLATION ---------
"Fetching the latest version of MSCODE.. please wait do not close this window!"
$ElapsedTime = Measure-Command {
  # The command to be timed goes here
  $wc = New-Object net.webclient
  $wc.Downloadfile($mscode_url, $local_mscode_installer)
}
# Get the total elapsed time in minutes
$TotalMinutes = $ElapsedTime.TotalMinutes
# Display the elapsed time in minutes
"Finished Download, Elapsed time: $TotalMinutes minutes"
Start-Process PowerShell $local_mscode_installer -wait


#------ KERNEL UPDATE INSTALLATION ---------
"Fetching the kernel update.."
$ElapsedTime = Measure-Command {
  # The command to be timed goes here
  $wc = New-Object net.webclient
  $wc.Downloadfile($kernel_update_url, $local_kernel_installer)
}
# Get the total elapsed time in minutes
$TotalMinutes = $ElapsedTime.TotalMinutes
# Display the elapsed time in minutes
"Finished Download, Elapsed time: $TotalMinutes minutes"

"Follow the install wizard."
# Wait for the MSI installer to finish
Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/i $local_kernel_installer" -wait

"(!) In the pop-up window hit Launch."

#------ UBUNTU Download & INSTALLATION ---------
"Fething the defined Ubuntu Image (~1Gb, it could take a while - do not close the powershell window)"
"Download has started in the background, please wait around 9.1 minutes.."
# Time the execution of a command
$ElapsedTime = Measure-Command {
  # The command to be timed goes here
  $wc = New-Object net.webclient
  $wc.Downloadfile($ubuntu_url, $local_ubuntu_location)
}

# Get the total elapsed time in minutes
$TotalMinutes = $ElapsedTime.TotalMinutes

# Display the elapsed time in minutes
"Finished Download, Elapsed time: $TotalMinutes minutes"
wsl --set-default-version 2
Add-AppxPackage $local_ubuntu_location
Start-Process PowerShell $local_ubuntu_location -wait