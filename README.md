# MS CODE CUSTOM DEVELOPMENT ENVIRONMENT
# MSCODE-CDE v3.0
- It's a custom development environment based on containers so that that it can be easy to share between machines and teams across different operating systems.
- The main goal is to have the same env and same tools in MSCode.
- Current main tools: 
    - check `image/.Dockerfile` 
    - git, aws-tools(awscli, MFA, ecs, k8s, etc.), cdk v2, etc.

### Main Author
- [Mircea Adam](https://github.com/mirceaadam)

### Contributions
- [Trond Kristiansen](https://github.com)

### Based On
- [Developing Inside A Container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container)


## REQUIREMENTS
#### Windows
[![Release New Version of MSCODE-CDE](https://github.com/mirceaadam/MSCODE-CDE/actions/workflows/main.yml/badge.svg)](https://github.com/mirceaadam/MSCODE-CDE/actions/workflows/main.yml)
- tested on: Windows 11 (Current release: Windows 11 2022 Update l Version 22H2)
- install WSL 2
- install docker desktop
- install [MSCODE](https://code.visualstudio.com/download)
#### M1 Mac ![Test passing](https://img.shields.io/badge/Tests-passing-brightgreen.svg)
- install docker desktop
- install [MSCODE](https://code.visualstudio.com/download)
#### Linux / Ubuntu / Debians
- install docker desktop
- install [MSCODE](https://code.visualstudio.com/download)

## USAGE for Linux / M1-Macs
### Establish a preffered working directory
- this will be somewhere you have alot of repositories
- we will assume you use `~`
- run the following (as an example):
    ```
    mkdir work && cd work
    git clone https://github.com/mirceaadam/MSCODE-CDE.git && cd MSCODE-CDE
    cp setup/user.config-example ../user.config && cd ..
    ```
- next, customize the variables in `user.config` replace `john.doe` with your name:
    
    [ CONTAINER-SPECIFIC ]
    - CONTAINER_NAME="MY-AWEOSAME-CDE" `#the name that will be displayed in MSCODE`
    - CONTAINER_LOCAL_IMG="mscodecde:latest" `#a random name for your docker image`
   
    [ AWS ]
    - AWS_SETUP="yes"
    - AWS_IAM_USERNAME="john.doe"
    - AWS_ARN_OF_MFA="arn:aws:iam::12345678910:mfa/john.doe" `#add your mfa ARN from IAM from your AWS user` 
    - AWS_TOKEN_DURATION=129600
    
    [ GIT ]
    - GIT_SETUP="yes"
    - GIT_EMAIL="john.doe@company.com"
    - GIT_USERNAME="John Doe"
    - If you are using AWS, make sure you have have locally files configured correctly: 
    - in `~/.aws` for linux
    - in `C:\User\your.name\.aws`
    - in this repository, `.aws-example` is an example of credentials
    - just replace: `xxxxxx` in `config` and `credentials`
- run:
    ```
    cd MSCODE-CDE
    chmod +x setup.sh
    bash setup.sh && cd .. && code .
    ```     
- `Note:` the script will delete the cloned repo at the end.
## OTHER INFORMATION
### updates version 3.0:
- credentials security (uses local ~/.aws) + .gitignore
- homedir fixes
- added (!) entrypoint.sh (more versatility)
- simple setup redesign
- local .Dokerfile image

### in the works:
- add support to build a container from inside the devcontainer  
- load extensions(Work in progress)
- example ~/.aws (Work in progress)
- aws configure(?) (Work in progress)
- more aws tools (Work in progress)
- azure / gsp support
- terraform support

### Major Versions 
- Version 3.0 ( november 2022 )
- Version 2.0 ( january 2022 )
- Version 1.0 ( november 2021 )
