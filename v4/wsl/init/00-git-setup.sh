#!usr/bin/env bash -e
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl

#Fetch INFO
source ~/.aws/user.config
GIT_SETUP=`echo $GIT_SETUP | tr -d '\012\015'`
GIT_EMAIL=`echo $GIT_EMAIL | tr -d '\012\015'`
GIT_USERNAME=`echo $GIT_USERNAME | tr -d '\012\015'`

echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------------  GIT   ---------------------"
echo -e "-------------------- --------------- -----------------------------"
if [ "$GIT_SETUP" = "yes" ]; then
    echo "Setting up your git globals..."
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_USERNAME"
    echo -e "completed \xE2\x9C\x94"
    git config --list
else
    echo "Skipped by request."
    exit
fi
