#!usr/bin/env bash
#Copy Credentials to local container
HOME=".devcontainer"
echo "Setting up your aws credentials in the container..."
mkdir -p ~/.aws
cp .secrets/.aws/* /root/.aws/
echo -e "listing AWS Credential files:"
ls /root/.aws/
echo -e "listing HOME_CONTAINER"
ls ~
echo -e "completed \xE2\x9C\x94"

#Set Token at container init
chmod +x $HOME/awstools/aws-get-token.sh
bash $HOME/awstools/aws-get-token.sh

rm -rf $HOME/.secrets