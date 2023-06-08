#!/bin/bash -e

#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl

echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------------  DEVOPS WSL CDE v4.0   ---------------------"
echo -e "-------------------- --------------- -----------------------------" 


# PRE_INSTALL
PRE_INSTALL=${SETUP_DIR}/checks

for file in `ls -1 $PRE_INSTALL/ | sort`; do
    file=$PRE_INSTALL/$file
    chmod +x $file
    echo -e "processing: $file"
    if [ -x $file ]; then
        echo -e "running: $file"
        bash $file
    fi
done

# INSTALL
#bash $SETUP_DIR/software/install.sh


# POST_INSTALL
POST_INSTALL=${SETUP_DIR}/init

for file in `ls -1 $POST_INSTALL/ | sort`; do
    file=$POST_INSTALL/$file
    chmod +x $file
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