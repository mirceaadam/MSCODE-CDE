#!/bin/bash
unset AWS_SECRET_ACCESS_KEY
unset AWS_SECRET_KEY
unset AWS_SESSION_TOKEN
HOME=".devcontainer"
source $HOME/awstools/user.config

AWS_USER_PROFILE=iam
AWS_2AUTH_PROFILE=mfa
ARN_OF_MFA=$AWS_ARN_OF_MFA
DURATION=$AWS_TOKEN_DURATION
USER=$AWS_IAM_USERNAME

echo "Hi $USER. "
echo "MFA ARN Detected: $ARN_OF_MFA , let's login."

unset password
prompt="Enter Your MFA TOKEN: "
while IFS= read -p "$prompt" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]
    then
        break
    fi
    prompt='*'
    password+="$char"
done
echo
read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN <<< \
$( aws --profile $AWS_USER_PROFILE sts get-session-token \
  --duration $DURATION  \
  --serial-number $ARN_OF_MFA \
  --token-code $password \
  --output text  | awk '{ print $2, $4, $5 }')
echo "AWS_ACCESS_KEY_ID: " $AWS_ACCESS_KEY_ID
echo "AWS_SECRET_ACCESS_KEY: " $AWS_SECRET_ACCESS_KEY
echo "AWS_SESSION_TOKEN: " $AWS_SESSION_TOKEN
if [ -z "$AWS_ACCESS_KEY_ID" ]
then
  exit 1
fi
`aws --profile $AWS_2AUTH_PROFILE configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"`
`aws --profile $AWS_2AUTH_PROFILE configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"`
`aws --profile $AWS_2AUTH_PROFILE configure set aws_session_token "$AWS_SESSION_TOKEN"`