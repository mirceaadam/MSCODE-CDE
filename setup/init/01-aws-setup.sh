#!usr/bin/env bash
#Copy Credentials to local container
echo "Setting up your aws credentials in the container..."
mkdir -p /root/.aws/
ls ~/.secrets/.aws/
cp ~/.secrets/.aws/* /root/.aws/
echo -e "listing AWS Credential files:"
ls /root/.aws/
echo -e "listing HOME_CONTAINER"
ls ~
echo -e "completed \xE2\x9C\x94"

#Set Token at container init
chmod +x ~/awstools/aws-get-token.sh
bash ~/awstools/aws-get-token.sh

rm -rf ~/.secrets