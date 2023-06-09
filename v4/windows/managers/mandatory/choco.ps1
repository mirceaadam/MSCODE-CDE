$chocoInstalled = Get-Command choco.exe -ErrorAction SilentlyContinue

if (-not $chocoInstalled) {
    Chocolatey is not installed, so install it
    Set-ExecutionPolicy Bypass -Scope Process -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    Chocolatey is installed, check for updates
    $latestVersion = (choco upgrade chocolatey --noop --whatif) 2>&1 | Select-String -Pattern "upgrading from (\d+\.\d+\.\d+\.\d+)" -AllMatches | Foreach-Object { $_.Matches.Groups[1].Value }

    if (-not [string]::IsNullOrEmpty($latestVersion)) {
        # There is a newer version of Chocolatey available, so upgrade it
        choco upgrade chocolatey -y
    }
    else {
        Write-Host "Chocolatey is already installed and up-to-date."
    }
}