#!usr/bin/env bash -e
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl

#Fetch INFO
source ~/.aws/user.config
AWS_IAM_USERNAME=`echo $AWS_IAM_USERNAME | tr -d '\012\015'`
AWS_SETUP=`echo $AWS_SETUP | tr -d '\012\015'`
AWS_REGION=`echo $AWS_REGION | tr -d '\012\015'`
AWS_TOKEN_DURATION=`echo $AWS_TOKEN_DURATION | tr -d '\012\015'`

echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------------  AWS GET TOKEN   ---------------------"
echo -e "-------------------- --------------- -----------------------------"
if [ "$AWS_SETUP" = "yes" ]; then
    echo "Adding get-token script.."
    cp -v $REPO_HOME/common/aws/* $HOME/.aws/
    chmod +x $HOME/.aws/aws-get-token.sh
    echo -e "Completed \xE2\x9C\x94"
    bash $HOME/.aws/aws-get-token.sh
else
    echo "Skipped by request."
    exit
fi
