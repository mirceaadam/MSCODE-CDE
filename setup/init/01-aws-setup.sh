#!usr/bin/env bash
#Copy Credentials to local container

echo "Setting up your aws credentials in the container..."
mkdir -p ~/.aws
cp -Rv .devcontainer/.secrets/.aws/* ~/.aws/
echo -e "completed \xE2\x9C\x94"

#Set Token at container init
chmod +x .devcontainer/awstools/aws-get-token.sh
bash .devcontainer/awstools/aws-get-token.sh

rm -rf .devcontainer/.secrets