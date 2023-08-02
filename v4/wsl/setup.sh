#!/bin/bash

#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl

echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------------  DEVOPS WSL CDE v4.0   ---------------------"
echo -e "-------------------- --------------- -----------------------------" 


# -----   PRE_INSTALL  ------
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

# -----   INSTALL  -----
echo -e ".....:: Begin INSTALL ::...."
bash $SETUP_DIR/software/install.sh
echo -e ".....:: Finish INSTALL ::...."


# -----   POST_INSTALL -------
echo -e ".....:: Begin POST_INSTALL ::...."
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

read -p "Would you like to login to awscli now? (Y/N): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    bash $HOME/.aws/getToken.sh
else
    echo "Have a great day!"
    exit 0
fi
