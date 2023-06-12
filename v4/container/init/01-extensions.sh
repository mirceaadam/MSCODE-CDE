#!usr/bin/env bash -e
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl

#Fetch INFO
source ~/.aws/user.config
MSCODE_EXTENSIONS=`echo $MSCODE_EXTENSIONS | tr -d '\012\015'`

echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------------  MSCODE EXTENSIONS   ---------------------"
echo -e "-------------------- --------------- -----------------------------" 
if [ "$MSCODE_EXTENSIONS" = "yes" ]; then
    cd $REPO_HOME/v4/common/extensions
    bash extensions.sh
    cd $SETUP_DIR # (!) get back in the install dir
else
    echo "Skipped by request."
    exit
fi