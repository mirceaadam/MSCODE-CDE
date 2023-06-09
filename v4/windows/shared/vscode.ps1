$mscode_url = 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user'
$local_mscode_installer = 'C:\Temp\CDE\VSCodeUserSetup-x64.exe'


#------ MSCODE INSTALLATION ---------
"Fetching the latest version of MSCODE.."
$ElapsedTime = Measure-Command {
  # The command to be timed goes here
  $wc = New-Object net.webclient
  $wc.Downloadfile($mscode_url, $local_mscode_installer)
}
# Get the total elapsed time in minutes
$TotalMinutes = $ElapsedTime.TotalMinutes
# Display the elapsed time in minutes
"Finished Download, Elapsed time: $TotalMinutes minutes"
#Start-Process PowerShell $local_mscode_installer -wait
"Installing mscode, do not close this window, please wait.."
" "
" "
" "
"When prompted, you can close MSCODE so that the installation may continue."
Start-Process $local_mscode_installer /VERYSILENT -NoNewWindow -Wait -PassThru
" "
"Cleaning up.."
rm $local_mscode_installer