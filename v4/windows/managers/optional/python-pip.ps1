#GLOBALS
$PYTHON_PATH = "C:\Users\$USER\AppData\Local\Programs\Python\$PYTHON_VERSION\"
$PYTHON_PATH_SCRIPTS = "C:\Users\$USER\AppData\Local\Programs\Python\$PYTHON_VERSION\Scripts\"
$PYTHON_VERSION = 'Python311'
$packageName = "Python.Python.3.11"
    # Install Python using WinGet
    Write-Host "Installing $packageName using WinGet..."
    winget install -q $packageName
    Write-Host "Installing pip.. "
    python -m pip install --upgrade pip
    # WINDOWS ENVIRONMENT VARIABLE FIX. STUPID, JUST STUPID.
    $pathValue = "$PYTHON_PATH"

    if ($env:Path -notlike "*$pathValue*") {
        $env:Path += ";$PYTHON_PATH;$PYTHON_PATH_SCRIPTS"
        [Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::User)
    }    