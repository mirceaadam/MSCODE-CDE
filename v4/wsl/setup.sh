#!/bin/bash -e

#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl


#Varitables Parsing because newlines or tabs are introduced sometimes.
source $REPO_HOME/v4/common/user.config
AWS_IAM_USERNAME=`echo $AWS_IAM_USERNAME | tr -d '\012\015'`
CONTAINER_NAME=`echo $CONTAINER_NAME | tr -d '\012\015'`
CONTAINER_LOCAL_IMG=`echo $CONTAINER_LOCAL_IMG | tr -d '\012\015'`
AWS_SETUP=`echo $AWS_SETUP | tr -d '\012\015'`
AWS_REGION=`echo $AWS_REGION | tr -d '\012\015'`
AWS_TOKEN_DURATION=`echo $AWS_TOKEN_DURATION | tr -d '\012\015'`
GIT_SETUP=`echo $GIT_SETUP | tr -d '\012\015'`
GIT_EMAIL=`echo $GIT_EMAIL | tr -d '\012\015'`
GIT_USERNAME=`echo $GIT_USERNAME | tr -d '\012\015'`
MSCODE_EXTENSIONS=`echo $MSCODE_EXTENSIONS | tr -d '\012\015'`


echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------------  DEVOPS WSL CDE v4.0   ---------------------"
echo -e "-------------------- --------------- -----------------------------" 

#bash $SETUP_DIR/software/install.sh

INIT_DIR=${SETUP_DIR}/init

for file in `ls -1 $INIT_DIR/ | sort`; do
    file=$INIT_DIR/$file
    echo -e "processing: $file"
    if [ -x $file ]; then
        echo -e "running: $file"
        bash $file
    fi
done

echo -e "Have fun creating wonderfull things!"
echo -e "\n"
echo -e "CONFIG COMPLETE."
echo -e "\n"
echo -e "\n"
echo -e "-------------------- --------------- -----------------------------"
echo -e "--------------------    NEXT STEP    -----------------------------"
echo -e "-------------------- --------------- -----------------------------" 
echo -e "RUN this command:                                                 "
echo -e "                         code .                                   "
echo -e "-------------------- --------------- -----------------------------"