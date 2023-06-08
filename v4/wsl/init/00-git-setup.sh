#!usr/bin/env bash -e
#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/wsl

#GIT setup
echo "Setting up your git in the container..."
git config --global user.email "%GIT_EMAIL%"
git config --global user.name "%GIT_USERNAME%"
echo -e "completed \xE2\x9C\x94"