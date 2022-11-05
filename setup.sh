#!/bin/bash
#unlink repo if cloned !
#git remote rm origin
source user.config
cd ..

#Varitables Parsing because newlines or tabs are introduced sometimes.
DEVCONTAINER=".devcontainer"
AWS_IAM_USERNAME=`echo $AWS_IAM_USERNAME | tr -d '\012\015'`
CONTAINER_NAME=`echo $CONTAINER_NAME | tr -d '\012\015'`
CONTAINER_LOCAL_IMG=`echo $CONTAINER_LOCAL_IMG | tr -d '\012\015'`
AWS_REGION=`echo $AWS_REGION | tr -d '\012\015'`
AWS_TOKEN_DURATION=`echo $AWS_TOKEN_DURATION | tr -d '\012\015'`
GIT_EMAIL=`echo $GIT_EMAIL | tr -d '\012\015'`
GIT_USERNAME=`echo $GIT_USERNAME | tr -d '\012\015'`


echo -e "-------------------- --------------- -----------------------------"
echo -e "-----------   MS CODE Custom Development ENV v2.0   --------------"
echo -e "-------------------- --------------- -----------------------------" 

echo -e "Let's build your dev image! \xE2\x9C\x94"
# docker build --no-cache - < ../image/.Dockerfile -t $CONTAINER_LOCAL_IMG
docker build - < ../image/.Dockerfile -t $CONTAINER_LOCAL_IMG

#add extensions for code !

if [ ! -d "$DEVCONTAINER" ]; then    
    mkdir -p $DEVCONTAINER
    cd $DEVCONTAINER

    echo "setting up .devcontainer.json"
    cat <<EOF > devcontainer.json
{
  "name": "$CONTAINER_NAME", 
  "image": "$CONTAINER_LOCAL_IMG",
  "forwardPorts": [3000],
  "postCreateCommand": "bash .devcontainer/ContainerStartupScript.sh"
}
EOF
    echo -e ".devcontainer folder does not exist - creating & configuring... \xE2\x9C\x94"

    cp ../setup/ContainerStartupScript.template ContainerStartupScript.sh
    sed -i "s/%GIT_EMAIL%/$GIT_EMAIL/g" ContainerStartupScript.sh
    sed -i "s/%GIT_USERNAME%/$GIT_USERNAME/g" ContainerStartupScript.sh
    chmod +x ContainerStartupScript.sh
    echo -e "configuring ContainerStartupScript.sh \xE2\x9C\x94"

    cp ../setup/ContainerSetToken.template ContainerSetToken.sh
    sed -i "s/%AWS_IAM_USERNAME%/$AWS_IAM_USERNAME/g" ContainerSetToken.sh
    sed -i "s/%AWS_TOKEN_DURATION%/$AWS_TOKEN_DURATION/g" ContainerSetToken.sh
    chmod +x ContainerSetToken.sh
    echo -e "configuring ContainerSetToken.sh \xE2\x9C\x94"
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



