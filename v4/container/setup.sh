#!/bin/bash -e
SETUP_LOCATION="MSCODE-CDE/v4/container"

echo -e "If you see this message, then we will start the devcontainer installation.."
echo -e " "
echo -e " "

echo -e "Enter the FULL PATH of location where you want to install."
echo -e "Examples:"
echo -e "- in WSL: /mnt/f/work , don't use ~"
echo -e "- in Linux: $HOME/work , don't use ~"
echo -e "- in MacOS: /Users/$USER/work , don't use ~"

read -p "Type Location:" DESTINATION
#Create a check here for $DESTINATION
echo -e "You Entered: $DESTINATION"

mkdir -p $DESTINATION
if [ -d "$DESTINATION" ]; then
    cd $DESTINATION
    git clone https://github.com/mirceaadam/MSCODE-CDE.git
    cd MSCODE-CDE/v4/container
    chmod +x install.sh
    bash install.sh
    cd ..
    echo -e "STARING DEVCONTAINER..."
    echo -e "When Prompted in vscode, press: [ REOPEN IN CONTAINER ]"
    code .
fi    