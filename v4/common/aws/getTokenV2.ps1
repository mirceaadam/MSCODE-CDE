function Show-Help {
    Write-Host "Usage: $([System.IO.Path]::GetFileName($MyInvocation.MyCommand.Path)) [MFA_TOKEN_CODE] [-h] [--help]"
    Write-Host
    Write-Host "This script updates the AWS session token for the specified profile."
    Write-Host
    Write-Host "Options:"
    Write-Host "  MFA_TOKEN_CODE       The MFA token code to use for authentication."
    Write-Host "                       If not provided, the script will prompt for it."
    Write-Host "  -h, --help           Show this help message and exit."
}

function Parse-Arguments {
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$MFA_TOKEN_CODE
    )

    if ($PSBoundParameters.ContainsKey('h') -or $PSBoundParameters.ContainsKey('help')) {
        Show-Help
        exit 0
    }

    if (-not [string]::IsNullOrEmpty($MFA_TOKEN_CODE)) {
        if ($MFA_TOKEN_CODE -match '^[0-9]{6}$') {
            $global:MFA_TOKEN_CODE = $MFA_TOKEN_CODE
        }
        else {
            Write-Host "Error: Invalid MFA token code. The code must be a 6-digit number."
            Show-Help
            exit 1
        }
    }
}

function Update-AWS-MFA-Profile {
    # Read profile values from the ~/.aws/credentials file
    $profileValues = @{}
    $profileNames = @()

    Get-Content -Path $HOME/.aws/credentials | ForEach-Object {
        $line = $_.Trim()

        if ($line -match '^\[(.*)\]$') {
            $profileName = $matches[1]
            $profileNames += $profileName
        }
        elseif (-not [string]::IsNullOrEmpty($line)) {
            $keyValue = $line -split '=', 2
            $key = $keyValue[0].Trim()
            $value = $keyValue[1].Trim()
            $profileValues["$profileName`_$key"] = $value
        }
    }

    # Prompt user to choose an AWS profile
    Write-Host "Available AWS profiles:"
    for ($i = 0; $i -lt $profileNames.Count; $i++) {
        Write-Host "$($i + 1)). $($profileNames[$i])"
    }

    $profileNumber = Read-Host "Enter the number of the AWS profile you want to use: "
    $chosenProfile = $profileNames[$profileNumber - 1]
    Write-Host "Chosen profile: $chosenProfile"

    # Retrieve the chosen profile values
    $chosenMfaAuthProfile = $profileValues["$chosenProfile`_mfa_auth_profile"]
    $chosenMfaDuration = $profileValues["$chosenProfile`_mfa_duration"]
    $chosenMfaArn = $profileValues["$chosenProfile`_mfa_arn"]
    $chosenMfaExpiry = $profileValues["$chosenProfile`_mfa_expiry"]

    # Force mfa_duration to be interpreted as an integer
    $chosenMfaDuration = [int]$chosenMfaDuration

    # Get the current time
    $currentTime = Get-Date -UFormat "%s"

    # Check if the session token has expired
    if ([string]::IsNullOrEmpty($chosenMfaExpiry) -or $currentTime -gt $chosenMfaExpiry) {
        # Use the MFA token code provided as a command-line argument or prompt the user for it
        if (-not [string]::IsNullOrEmpty($global:MFA_TOKEN_CODE)) {
            $mfaTokenCode = $global:MFA_TOKEN_CODE
        }
        else {
            $mfaTokenCode = Read-Host "Enter the MFA token code: "
        }

        # Call sts get-session-token with the selected profile values
        $newAwsSessionToken = aws --profile $chosenMfaAuthProfile sts get-session-token `
            --duration $chosenMfaDuration `
            --serial-number $chosenMfaArn `
            --token-code $mfaTokenCode `
            --output text | ForEach-Object { $_.Split(" ")[1..3] }

        $newAwsAccessKeyId = $newAwsSessionToken[0]
        $newAwsSecretAccessKey = $newAwsSessionToken[1]
        $newAwsSessionToken = $newAwsSessionToken[2]

        # Update AWS CLI profile with the new session token values
        aws configure set aws_access_key_id $newAwsAccessKeyId --profile $chosenProfile
        aws configure set aws_secret_access_key $newAwsSecretAccessKey --profile $chosenProfile
        aws configure set aws_session_token $newAwsSessionToken --profile $chosenProfile

        # Calculate and update mfa_expiry in the ~/.aws/credentials file
        $newMfaExpiry = $currentTime + $chosenMfaDuration
        (Get-Content -Path $HOME/.aws/credentials) | ForEach-Object {
            if ($_ -match "^\[$chosenProfile\]$") {
                $inProfile = $true
                $_
            }
            elseif ($_ -match "^\[.*\]$") {
                $inProfile = $false
                $_
            }
            elseif ($inProfile -and $_ -match "^mfa_expiry\s*=.*$") {
                $_ -replace "mfa_expiry\s*=.*$", "mfa_expiry = $newMfaExpiry"
            }
            else {
                $_
            }
        } | Set-Content -Path $HOME/.aws/credentials -Force

        # If the mfa_expiry key is not found in the chosen profile, append it
        $mfaExpiryKeyExists = (Select-String -Pattern "^mfa_expiry\s*=.*$" -Path $HOME/.aws/credentials | Where-Object { $_ -match "^\[$chosenProfile\]$" }).Count -gt 0
        if (-not $mfaExpiryKeyExists) {
            Add-Content -Path $HOME/.aws/credentials -Value "`n[$chosenProfile]`nmfa_expiry = $newMfaExpiry"
        }
    }
}

# Execute the function if the script is being run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Parse-Arguments $args
    Update-AWS-MFA-Profile
}
       
