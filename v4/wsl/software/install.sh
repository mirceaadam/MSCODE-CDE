#!/bin/bash
apt-get update && apt-get install -y -qq \
    python3-pip \
    git \
    curl \
    vim \
    jq \
    wget

pip3 install \
    awscli \
    git-remote-codecommit

curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sh nodesource_setup.sh
apt-get install -y -qq nodejs
#install CDK
npm install -g aws-cdk    
# Uses "robbyrussell" theme (original Oh My Zsh theme), with no plugins
sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell