#!usr/bin/env bash
echo "I am in:" 
echo ${PWD##*/}
SETUP_PATH="${PWD##*/}"

#Set Token at container init
echo "Adding get-token script.."
cp -v $SETUP_PATH/common/aws/* $HOME/.aws/
echo -e "completed \xE2\x9C\x94"
chmod +x $HOME/.aws/aws-get-token.sh
bash $HOME/.aws/aws-get-token.sh