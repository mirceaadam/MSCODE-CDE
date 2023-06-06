#!usr/bin/env bash
echo "Installing VSCODE Extensions"
for extension in $(cat extensions.json | jq -r '.[] | .id'); 
do code --install-extension $extension; 
done
