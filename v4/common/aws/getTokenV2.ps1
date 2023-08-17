#
$env:AWS_SECRET_ACCESS_KEY = $null
$env:AWS_SECRET_KEY = $null
$env:AWS_SESSION_TOKEN = $null

# Define the path to the config file
$configFilePath = "~\.aws\credentials"

# Read the contents of the config file
$configContents = Get-Content -Path $configFilePath

# Initialize variables
$ARN_OF_MFA = $null
$DURATION = $null

# Loop through each line in the config file
foreach ($line in $configContents) {
    if ($line -match "^\s*mfa_arn\s*=\s*(.+)$") {
        $ARN_OF_MFA = $matches[1]
    } elseif ($line -match "^\s*mfa_duration\s*=\s*(\d+)$") {
        $DURATION = $matches[1]
    }
}

# Display the extracted values
#Write-Host "ARN_OF_MFA: $ARN_OF_MFA"
#Write-Host "DURATION: $DURATION"


$AWS_USER_PROFILE = "iam"
$AWS_2AUTH_PROFILE = "mfa"
# $ARN_OF_MFA = $env:mfa_arn -replace '[\r\n]+'
# $DURATION = $env:mfa_duration -replace '[\r\n]+'

Write-Output "Hi $env:USERNAME!"
Write-Output "MFA ARN Detected: $ARN_OF_MFA, let's login."

$password = Read-Host -Prompt "Enter Your MFA TOKEN" -AsSecureString
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

$credentials = aws --profile $AWS_USER_PROFILE sts get-session-token `
  --duration $DURATION `
  --serial-number $ARN_OF_MFA `
  --token-code $plainPassword `
  --output text | ForEach-Object {
      $tokens = $_ -split '\s+' -replace '[\r\n]+'
      $tokens[1], $tokens[3], $tokens[4]
  }

#Write-Host $credentials  
  
$AWS_ACCESS_KEY_ID, $AWS_SECRET_ACCESS_KEY, $AWS_SESSION_TOKEN = $credentials

Write-Output "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
Write-Output "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
Write-Output "AWS_SESSION_TOKEN: $AWS_SESSION_TOKEN"

if ([string]::IsNullOrEmpty($AWS_ACCESS_KEY_ID)) {
    exit 1
}

aws --profile $AWS_2AUTH_PROFILE configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws --profile $AWS_2AUTH_PROFILE configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws --profile $AWS_2AUTH_PROFILE configure set aws_session_token "$AWS_SESSION_TOKEN"