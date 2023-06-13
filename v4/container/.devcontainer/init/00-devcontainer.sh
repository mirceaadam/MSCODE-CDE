#/bin/bash -e

#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/container
DEVCONTAINER=".devcontainer"


if [ ! -d "$DEVCONTAINER" ]; then
    echo -e "::INIT:: .devcontainer not found - starting config."    
    mkdir -p $DEVCONTAINER/init
    cd $DEVCONTAINER
    cp $SETUP_DIR/setup/entrypoint.sh .
    echo "setting up .devcontainer.json"

echo -e "::INIT:: preparing your .devcontainer"
if [ "$GIT_SETUP" = "yes" ]; then    
    cp -v $INSTALL_DIR/setup/init/00-git-setup.sh init/00-git-setup.sh
    ls -l init/00-git-setup.sh
    sed -i '' -e "s/%GIT_EMAIL%/$GIT_EMAIL/g" init/00-git-setup.sh
    sed -i '' -e "s/%GIT_USERNAME%/$GIT_USERNAME/g" init/00-git-setup.sh
    chmod +x init/00-git-setup.sh
    echo -e "completed \xE2\x9C\x94"