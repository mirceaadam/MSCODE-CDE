#!/bin/bash
# NVM / NODE
# check this: https://learn.microsoft.com/en-us/windows/dev-environment/javascript/nodejs-on-wsl

read -p "Would you like to install CDK now? (Y/N): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    source ~/.bashrc
    nvm install node
    nvm use node

    # CDK
    npm install -g aws-cdk
else
    echo "Have a great day!"
    exit 0
fi