#!/bin/bash
unset AWS_SECRET_ACCESS_KEY
unset AWS_SECRET_KEY
unset AWS_SESSION_TOKEN
source .devcontainer/awstools/aws.user.config
AWS_USER_PROFILE=$DEVCONTAINER_AWS_USER_PROFILE
AWS_2AUTH_PROFILE=2auth
ARN_OF_MFA=$DEVCONTAINER_AWS_ARN_OF_MFA
DURATION=$DEVCONTAINER_AWS_TOKEN_DURATION
AWS_CLI_PROFILE=$DEVCONTAINER_AWS_CLI_PROFILE

echo "AWS-CLI Profile: $AWS_CLI_PROFILE"
echo "MFA ARN: $ARN_OF_MFA"
# echo "MFA Token Code: $MFA_TOKEN_CODE"
# set -x
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