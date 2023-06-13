#!/bin/bash -e

#GLOBALS
PWD=`pwd`
REPO_HOME=${PWD}
SETUP_DIR=${PWD}/v4/container
CONTAINER_TAG="mscodecde:latest"
IMAGE="ubuntu" #coresponds with the folder

echo -e "Let's build your $IMAGE $CONTAINER_TAG image! \xE2\x9C\x94"
# docker build --no-cache - < ../image/.Dockerfile -t $CONTAINER_LOCAL_IMG
docker build - < $SETUP_DIR/$IMAGE/.Dockerfile -t $CONTAINER_TAG
