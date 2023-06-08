#!usr/bin/env bash -e
aws_folder=~/.aws

if [ -d "$aws_folder" ]; then
    echo "The folder $aws_folder exists."
else
    read -p "The folder $aws_folder does not exist. Do you want to proceed? (Y/N): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "Proceeding with further actions."
    else
        echo "Aborting further actions."
        exit 0
    fi
fi