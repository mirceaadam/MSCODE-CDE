#!/bin/bash
INSTALL_DIR=`pwd`
cd ..
source ~/.aws/user.config
WORKDIR=${PWD##*/}
DEVCONTAINER=".devcontainer"

#Varitables Parsing because newlines or tabs are introduced sometimes.
AWS_IAM_USERNAME=`echo $AWS_IAM_USERNAME | tr -d '\012\015'`
CONTAINER_NAME=`echo $CONTAINER_NAME | tr -d '\012\015'`
CONTAINER_LOCAL_IMG=`echo $CONTAINER_LOCAL_IMG | tr -d '\012\015'`
AWS_SETUP=`echo $AWS_SETUP | tr -d '\012\015'`
AWS_REGION=`echo $AWS_REGION | tr -d '\012\015'`
AWS_TOKEN_DURATION=`echo $AWS_TOKEN_DURATION | tr -d '\012\015'`
GIT_SETUP=`echo $GIT_SETUP | tr -d '\012\015'`
GIT_EMAIL=`echo $GIT_EMAIL | tr -d '\012\015'`
GIT_USERNAME=`echo $GIT_USERNAME | tr -d '\012\015'`
MSCODE_EXTENSIONS=`echo $MSCODE_EXTENSIONS | tr -d '\012\015'`


echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------   MS CODE Custom Development ENV v4.1   --------------"
echo -e "-------------------- --------------- -----------------------------" 

echo -e "Let's build your dev image! \xE2\x9C\x94"
# docker build --no-cache - < ../image/.Dockerfile -t $CONTAINER_LOCAL_IMG
docker build - < $INSTALL_DIR/image/.Dockerfile -t $CONTAINER_LOCAL_IMG

#add extensions for code !

if [ ! -d "$DEVCONTAINER" ]; then
    echo -e "::SETUP:: .devcontainer not found - starting config."    
    mkdir -p $DEVCONTAINER/init
    cd $DEVCONTAINER
    cp $INSTALL_DIR/setup/entrypoint.sh .
    echo "setting up .devcontainer.json"
    cat <<EOF > devcontainer.json
{
  "name": "$CONTAINER_NAME", 
  "image": "$CONTAINER_LOCAL_IMG",
  "forwardPorts": [3000],
  "postCreateCommand": "bash .devcontainer/entrypoint.sh" 
}
EOF
    echo -e "::SETUP:: preparing your git"
    if [ "$GIT_SETUP" = "yes" ]; then    
        cp -v $INSTALL_DIR/setup/init/00-git-setup.sh init/00-git-setup.sh
        ls -l init/00-git-setup.sh
        sed -i '' -e "s/%GIT_EMAIL%/$GIT_EMAIL/g" init/00-git-setup.sh
        sed -i '' -e "s/%GIT_USERNAME%/$GIT_USERNAME/g" init/00-git-setup.sh
        chmod +x init/00-git-setup.sh
        echo -e "completed \xE2\x9C\x94"
    fi

    # echo -e "::SETUP:: preparing your vscode in the container"
    # if [ "$MSCODE_EXTENSIONS" = "yes" ]; then
    #     mkdir -p vscode
    #     cp -v $INSTALL_DIR/setup/init/01-vscode-setup.sh init/01-vscode-setup.sh
    #     cp -v $INSTALL_DIR/setup/vscode/extensions.json vscode/extensions.json
    #     chmod +x init/01-vscode-setup.sh
    #     echo -e "completed \xE2\x9C\x94"
    # fi

    if [ "$AWS_SETUP" = "yes" ]; then
        echo -e "::SETUP:: configuring AWS MFA TOKEN Script"     
        cp $INSTALL_DIR/setup/init/02-aws-setup.sh init/02-aws-setup.sh 
        echo -e "workdir is: $WORKDIR"
        sed -i '' -e "s/%CONTAINER_WORKDIR%/$WORKDIR/g" init/02-aws-setup.sh
        echo -e "completed \xE2\x9C\x94"        
    fi

    echo -e "\n"
    echo -e "CONFIG COMPLETE."
    echo -e "\n"
    echo -e "\n"
    echo -e "-------------------- --------------- -----------------------------"
    echo -e "--------------------    NEXT STEP    -----------------------------"
    echo -e "-------------------- --------------- -----------------------------" 
    echo -e "RUN this command:                                                 "
    echo -e "                         code .                                   "
    echo -e "-------------------- --------------- -----------------------------"         
fi

#rm -rf $INSTALL_DIR
