$packageName = "nvm"

# Check if NVM is installed
$nvmInstalled = choco list --local-only | Select-String -Pattern '^nvm'

if ($nvmInstalled) {
    Write-Host "NVM (Node Version Manager) is already installed."
    # Update NVM using Chocolatey
    Write-Host "Updating NVM using Chocolatey..."
    choco upgrade $packageName -y
}
else {
    # Install NVM using Chocolatey
    Write-Host "Installing NVM using Chocolatey..."
    choco install $packageName -y
}