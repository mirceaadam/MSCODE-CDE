#!/bin/bash -e
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl


sudo apt-get update
sudo apt-get install -y -qq \
    python3-pip \
    git \
    curl \
    vim \
    jq \
    wget



# AWSCLI Latest
sudo apt install glibc-source groff less unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# git-remote-codecommit
pip3 install git-remote-codecommit

# NVM / NODE
# check this: https://learn.microsoft.com/en-us/windows/dev-environment/javascript/nodejs-on-wsl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm use node

# CDK
npm install -g aws-cdk

# Uses "robbyrussell" theme (original Oh My Zsh theme), with no plugins
sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell