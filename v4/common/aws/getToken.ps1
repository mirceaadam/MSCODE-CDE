#
$env:AWS_SECRET_ACCESS_KEY = $null
$env:AWS_SECRET_KEY = $null
$env:AWS_SESSION_TOKEN = $null

$userConfigFile = "~/.aws/user.config"
if (Test-Path $userConfigFile) {
    $userConfig = Get-Content $userConfigFile
    $userConfig | ForEach-Object {
        $line = $_ -replace '\s+', ''
        if ($line -match '^(.*?)=(.*)$') {
            $envName = $Matches[1]
            $envValue = $Matches[2]
            Set-Item -Path "env:$envName" -Value $envValue
        }
    }
}


$AWS_USER_PROFILE = "iam"
$AWS_2AUTH_PROFILE = "mfa"
$ARN_OF_MFA = $env:AWS_ARN_OF_MFA -replace '[\r\n]+'
$DURATION = $env:AWS_TOKEN_DURATION -replace '[\r\n]+'
$USER = $env:AWS_IAM_USERNAME -replace '[\r\n]+'

Write-Output "Hi $USER!"
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