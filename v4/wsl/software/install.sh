#!/bin/bash -e
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl


sudo apt-get update
cat $SETUP_DIR/software/apt.txt | xargs -L 1 sudo apt-get install -y -qq
cat $SETUP_DIR/software/pip.txt | xargs -L 1 pip3 install 

curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sh nodesource_setup.sh
#install CDK
npm install -g aws-cdk    
# Uses "robbyrussell" theme (original Oh My Zsh theme), with no plugins
sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell