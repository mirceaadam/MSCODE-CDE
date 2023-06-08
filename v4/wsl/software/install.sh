#!/bin/bash -e
apt-get update
cat ./apt.txt | xargs -L 1 apt-get install -y -qq
cat ./pip.txt | xargs -L 1 pip3 install 

curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sh nodesource_setup.sh
#install CDK
npm install -g aws-cdk    
# Uses "robbyrussell" theme (original Oh My Zsh theme), with no plugins
sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell