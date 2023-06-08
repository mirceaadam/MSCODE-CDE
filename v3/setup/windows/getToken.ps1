#
# Based on : https://github.com/EvidentSecurity/MFAonCLI/blob/master/aws-temp-token.sh
#
# Parameters
$ProgressPreference = 'SilentlyContinue'
param($MFA_TOKEN_CODE, $IAMUSERNAME);
#If you dont want to pass along username each time you could input your name on line 24
#install-module -name AWSPowerShell.NetCore -AllowClobber
#import-module AWSPowerShell.NetCore
$awstools;
try { 
  $awstools = (Get-STSSessionToken) | Out-String
}
catch {
  $awstools = $_ | Out-String
}
if($awstools.Contains("CommandNotFoundException")){
  Write-Output "AWSTOOLS POWERSHELL not installed, installing it"
  #Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  Set-ExecutionPolicy Bypass -Force
  install-module -name AWSPowerShell.NetCore -AllowClobber -Force
  import-module AWSPowerShell.NetCore
}
# save output of the commend to check wether aws cli is installed
$awscli;
try { 
  $awscli = (aws --version) 
}
catch {
  $awscli = $_ | Out-String
}
# loook for the is not recognized as, which means its not installed
$awscli = $awscli.Contains("is not recognized as")
# if this is true, that means cli is not installed, hence install it
if ($awscli) {
  write-host "AWS CLI not installed, installing it"
 
  Invoke-WebRequest -Uri https://awscli.amazonaws.com/AWSCLIV2.msi -OutFile AWSCLIV2.msi
  MsiExec.exe /i AWSCLIV2.msi /qn
}
if (!$MFA_TOKEN_CODE){
  Write-Output "Usage: setCrendentials MFA_TOKEN_CODE=<MFA_TOKEN_CODE>"
  Write-Output "Where:"
  Write-Output "   <MFA_TOKEN_CODE> = Code from virtual MFA device"
  exit 2
}
if (!$IAMUSERNAME){
  #Set your iam username to dont have to pass it along each time
  $IAMUSERNAME = "your.username"
}
$AWS_USER_PROFILE="iam"
$AWS_2AUTH_PROFILE="mfa"
$ARN_OF_MFA="arn:aws:iam::12345678910:mfa/$IAMUSERNAME"
$DURATION=129600
Write-Output "AWS-CLI Profile: $AWS_USER_PROFILE"
Write-Output "MFA ARN: $ARN_OF_MFA"
Write-Output "MFA Token Code: $MFA_TOKEN_CODE"
$awsResult = Get-STSSessionToken -ProfileName $AWS_USER_PROFILE -DurationInSeconds $DURATION -SerialNumber $ARN_OF_MFA -TokenCode $MFA_TOKEN_CODE
#Setting the aws credential in the shell
Set-AWSCredential -ProfileLocation ~\.aws\credentials  -AccessKey $awsResult.AccessKeyId -SecretKey $awsResult.SecretAccessKey -SessionToken $awsResult.SessionToken -StoreAs $AWS_2AUTH_PROFILE
if (!$awsResult){
  exit 1
}
#Writing the profile to persistent credential file using the standard aws cli command
aws --profile $AWS_2AUTH_PROFILE configure set aws_access_key_id $awsResult.AccessKeyId
aws --profile $AWS_2AUTH_PROFILE configure set aws_secret_access_key $awsResult.SecretAccessKey
aws --profile $AWS_2AUTH_PROFILE configure set aws_session_token $awsResult.SessionToken
