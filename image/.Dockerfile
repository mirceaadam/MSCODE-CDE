# MS CODE Custom Development ENV v2.0 Docker Image
# Customize & install what tools you like and need.
FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y -qq \
    python3-pip \
    git \
    curl \
    wget
RUN pip3 install awscli
RUN pip3 install git-remote-codecommit
### install kubectl
# RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
### install eksctl
# RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
#     | tar xz -C /tmp && \
#     mv /tmp/eksctl /usr/local/bin
#install nodejs 16.x
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
RUN sh nodesource_setup.sh
RUN apt-get install -y -qq nodejs
#install CDK
RUN npm install -g aws-cdk    
# Uses "robbyrussell" theme (original Oh My Zsh theme), with no plugins
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell