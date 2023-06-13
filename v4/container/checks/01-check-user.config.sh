#!usr/bin/env bash -e
config_file=~/.aws/user.config

if [ -f "$config_file" ]; then
    echo "The file $config_file exists."
else
    echo "The file $config_file does not exist."
    cp -v $REPO_HOME/v4/common/user.config ~/.aws/
fi