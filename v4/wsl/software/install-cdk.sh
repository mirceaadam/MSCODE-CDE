#!/bin/bash
# NVM / NODE
# check this: https://learn.microsoft.com/en-us/windows/dev-environment/javascript/nodejs-on-wsl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm install node
nvm use node

# CDK
npm install -g aws-cdk
