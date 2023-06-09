#GLOBALS
$kernel_update_url = 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'

#$ubuntu_url = 'https://aka.ms/wslubuntu2204' #1GB in size and slow download.
$ubuntu_url = 'https://wslstorestorage.blob.core.windows.net/wslblob/Ubuntu2204LTS-230418_x64.appx'
#https://learn.microsoft.com/en-us/windows/wsl/install-manual?source=docs#downloading-distributions
# (check here for latest ubuntu) 
# https://github.com/microsoft/WSL/blob/master/distributions/DistributionInfo.json

$local_ubuntu_installer = 'C:\Temp\Ubuntu.appx'
$local_kernel_installer = 'C:\Temp\wsl_update_x64.msi'

" ....::: WSL Installation :::...."
"Let's begin."
" "

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
"Installing kernel update, do not close this windows, please wait.."
# Wait for the MSI installer to finish
Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/i $local_kernel_installer /qn" -wait

#------ UBUNTU Download & INSTALLATION ---------
"Fething the defined Ubuntu Image "
"(~600Mb, it could take a while - DO NOT CLOSE this powershell window)"
$currentTime = Get-Date
"Started the download at: $currentTime"
"...please wait around 5 minutes."
    # Time the execution of a command
    $ElapsedTime = Measure-Command {
        # The command to be timed goes here
        $wc = New-Object net.webclient
        $wc.Downloadfile($ubuntu_url, $local_ubuntu_installer)
    }

# Get the total elapsed time in minutes
$TotalMinutes = $ElapsedTime.TotalMinutes

# Display the elapsed time in minutes
"Finished Download, Elapsed time: $TotalMinutes minutes"
" "
"DO NOT CLOSE THIS WINDOW."
"When prompted, Hit LAUNCH and install ubuntu."
"Provide a username/password when prompted - DO NOT LOSE IT !"
wsl --set-default-version 2
Add-AppxPackage $local_ubuntu_installer
Start-Process PowerShell $local_ubuntu_installer -wait