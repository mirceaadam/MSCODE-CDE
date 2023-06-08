$packageName = "Python.Python.3.11"

# Check if Python is installed
$pythonInstalled = Get-Command python -ErrorAction SilentlyContinue

if ($pythonInstalled) {
    Write-Host "Python is already installed."
    # Skip or exit the script if Python is already installed
    # Add your desired logic here
    Write-Host "Checking pip.. "
    python -m pip install --upgrade pip
}
else {
    # Install Python using WinGet
    Write-Host "Installing $packageName using WinGet..."
    winget install $packageName -q
    Write-Host "Installing pip.. "
    python -m pip install --upgrade pip    
}