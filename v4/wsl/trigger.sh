#!/bin/bash
echo "If you see this message, then we will start the WSL customization."
echo "I will need permission to install wslu tool with apt in order to link correctly ~/.aws"
echo "Please authorize by providing the sudo password."
sudo apt-get install wslu #used to do translation of paths from windows to wsl

echo "Creating the link."
ln -s "$(wslvar USERPROFILE)/.aws" ~/.aws
echo "Check that it is created:"
ls -larnt ~/.aws

cd ~ \
    && git clone https://github.com/mirceaadam/MSCODE-CDE.git \
    && cd MSCODE-CDE && bash v4/wsl/setup.sh