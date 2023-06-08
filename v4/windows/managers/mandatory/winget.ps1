$wingetInstalled = Get-Command winget.exe -ErrorAction SilentlyContinue

if (-not $wingetInstalled) {
    # Winget is not installed, so install it
    $wingetInstallerPath = Join-Path $env:TEMP "winget-cli.msixbundle"
    $wingetInstallerUri = "https://github.com/microsoft/winget-cli/releases/latest/download/winget-cli.msixbundle"

    Invoke-WebRequest -Uri $wingetInstallerUri -OutFile $wingetInstallerPath
    Add-AppxPackage -Path $wingetInstallerPath
    Remove-Item $wingetInstallerPath
}
else {
    # Winget is installed, check for updates
    $wingetVersion = winget --version

    $latestVersion = (winget upgrade --list) -split [Environment]::NewLine | Select-String -Pattern "Microsoft.Winget.* (\d+\.\d+\.\d+\.\d+)" -AllMatches | Foreach-Object { $_.Matches.Groups[1].Value }

    if (-not [string]::IsNullOrEmpty($latestVersion) -and $latestVersion -ne $wingetVersion) {
        # There is a newer version of Winget available, so upgrade it
        winget upgrade --all -y
    }
    else {
        Write-Host "Winget is already installed and up-to-date."
    }
}
