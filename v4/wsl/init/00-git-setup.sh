#!usr/bin/env bash
#GIT setup
echo "Setting up your git in the container..."
git config --global user.email "%GIT_EMAIL%"
git config --global user.name "%GIT_USERNAME%"
echo -e "completed \xE2\x9C\x94"