#GLOBALS
$download_url = 'https://www.powershellgallery.com/packages/idf-ext/1.0/Content/Update-SessionEnvironment.ps1'
$script_location = 'C:\Temp\CDE\Update-SessionEnvironment.ps1'

function RefreshWindowsEnvironment {
      #------ RefreshWindowsEnvironment INSTALLATION ---------
      "Fetching the latest version of RefreshWindowsEnvironment.."
      $ElapsedTime = Measure-Command {
        # The command to be timed goes here
        $wc = New-Object net.webclient
        $wc.Downloadfile($download_url, $script_location)
      }
      # Get the total elapsed time in minutes
      $TotalMinutes = $ElapsedTime.TotalMinutes
      # Display the elapsed time in minutes
      "Finished Download, Elapsed time: $TotalMinutes minutes"
      "Refreshing Windows Environment.."
      Start-Process PowerShell $script_location -wait
      "Done."
  }

  RefreshWindowsEnvironment  