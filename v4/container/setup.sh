#!/bin/bash
SETUP_LOCATION="MSCODE-CDE/v4/container"

echo -e "If you see this message, then we will start the devcontainer installation.."
echo -e " "
echo -e " "

echo -e "Enter the FULL PATH of location where you want to install."
echo -e "Examples:"
echo -e "- in WSL: /mnt/f/work or ~/work"
echo -e "- in Linux: /home/$USER/work or ~/work"
echo -e "- in MacOS: /home/$USER/work or ~/work"
echo -e "Type Location:"
read $DESTINATION
#Create a check here for $DESTINATION

mkdir $DESTINATION && cd $DESTINATION
git clone https://github.com/mirceaadam/MSCODE-CDE.git \
    && cd $SETUP_LOCATION \
    chmod +x install.sh \
    bash install.sh \
    && cd .. \
    echo -e "STARING DEVCONTAINER..." \
    echo -e "When Prompted in vscode, press: [ REOPEN IN CONTAINER ]" \
    && code .