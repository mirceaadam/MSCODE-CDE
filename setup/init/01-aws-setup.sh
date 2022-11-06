#!usr/bin/env bash
#Copy Credentials to local container
echo "Setting up your aws credentials in the container..."
WORKDIR="%CONTAINER_WORKDIR%"
echo $WORKDIR
SETUP_PATH="/workspaces/$WORKDIR/.devcontainer"
mkdir -p /root/.aws/
echo -e "BA ESTI PROST?????"
ls ~
echo -e "da!!!"
ls $SETUP_PATH/.secrets/.aws/
cp $SETUP_PATH/.secrets/.aws/* /root/.aws/
echo -e "listing AWS Credential files:"
ls /root/.aws/
echo -e "listing HOME_CONTAINER"
ls ~
echo -e "completed \xE2\x9C\x94"

#Set Token at container init
chmod +x $SETUP_PATH/awstools/aws-get-token.sh
bash $SETUP_PATH/awstools/aws-get-token.sh

rm -rf $SETUP_PATH/.secrets