#!usr/bin/env bash -e
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl

echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------------  AWS GET TOKEN   ---------------------"
echo -e "-------------------- --------------- -----------------------------"

#Set Token at container init
echo "Adding get-token script.."
cp -v $REPO_HOME/common/aws/* $HOME/.aws/
chmod +x $HOME/.aws/aws-get-token.sh
echo -e "Completed \xE2\x9C\x94"
bash $HOME/.aws/aws-get-token.sh