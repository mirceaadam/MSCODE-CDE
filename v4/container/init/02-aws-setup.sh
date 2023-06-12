#!usr/bin/env bash -e
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl

#Fetch INFO
source ~/.aws/user.config
AWS_SETUP=`echo $AWS_SETUP | tr -d '\012\015'`

echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------------  AWS GET TOKEN   ---------------------"
echo -e "-------------------- --------------- -----------------------------"
if [ "$AWS_SETUP" = "yes" ]; then
    #copying..
    echo "Adding get-token script.."
    cp -v $REPO_HOME/v4/common/aws/* $HOME/.aws/
    chmod +x $HOME/.aws/getToken.sh
    #add to bash for quick access
    alias getToken='bash ~/.aws/getToken.sh'
    source ~/.bashrc
    echo "Making getToken available system-wide"
    sudo ln -s ~/.aws/getToken.sh /usr/local/bin/getToken
    echo -e "Completed \xE2\x9C\x94"
else
    echo "Skipped by request."
    exit
fi
