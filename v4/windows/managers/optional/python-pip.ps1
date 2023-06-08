$packageName = "Python.Python.3.11"
    # Install Python using WinGet
    Write-Host "Installing $packageName using WinGet..."
    winget install $packageName -q
    Write-Host "Installing pip.. "
    python -m pip install --upgrade pip