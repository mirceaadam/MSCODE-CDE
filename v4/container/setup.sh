#!/bin/bash -e

#GLOBALS
ver="4.0"
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/container

echo -e "-------------------- --------------- -----------------------------"
echo -e "------------  DEVOPS CONTAINER SETUP CDE $ver   ------------------"
echo -e "-------------------- --------------- -----------------------------" 


# -----   PRE_BUILD  ------
PRE_BUILD=${SETUP_DIR}/checks

for file in `ls -1 $PRE_BUILD/ | sort`; do
    file=$PRE_BUILD/$file
    chmod +x $file
    echo -e "processing: $file"
    if [ -x $file ]; then
        echo -e "running: $file"
        bash $file
    fi
done

# -----   BUILD  -----   
bash $SETUP_DIR/build.sh


# -----   POST_BUILD -------
POST_BUILD=${SETUP_DIR}/init

for file in `ls -1 $POST_BUILD/ | sort`; do
    file=$POST_BUILD/$file
    chmod +x $file
    echo -e "processing: $file"
    if [ -x $file ]; then
        echo -e "running: $file"
        bash $file
    fi
done

echo -e "Have fun creating wonderfull things!"
echo -e "\n"
echo -e "CONFIG COMPLETE.  [ \xE2\x9C\x94 ]"

# read -p "Would you like to login to awscli now? (Y/N): " response
# if [[ "$response" =~ ^[Yy]$ ]]; then
#     bash $HOME/.aws/getToken.sh
# else
#     echo "Have a great day!"
#     exit 0
# fi