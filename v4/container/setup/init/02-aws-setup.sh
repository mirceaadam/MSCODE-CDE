#!usr/bin/env bash
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl
#Copy Credentials to local container
echo "Setting up your aws credentials in the container..."
WORKDIR="%CONTAINER_WORKDIR%"
echo $WORKDIR
SETUP_PATH="/workspaces/$WORKDIR/.devcontainer"
mkdir -p /root/.aws/
ls ~/.aws/

#copying..
echo "Adding get-token script.."
cp -v $REPO_HOME/v4/common/aws/* $HOME/.aws/
chmod +x $HOME/.aws/getToken.sh
echo -e "listing HOME_CONTAINER:"
ls -l ~
echo -e "completed \xE2\x9C\x94"

#add to bash for quick access
alias getToken='bash ~/.aws/getToken.sh'
source ~/.bashrc
echo "Making getToken available system-wide"
sudo ln -s ~/.aws/getToken.sh /usr/local/bin/getToken
echo -e "Completed \xE2\x9C\x94"


#Set Token at container init
bash $HOME/.aws/getToken.sh