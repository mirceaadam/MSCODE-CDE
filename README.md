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
- run the following:
    ```
    mkdir work && cd work
    git clone https://github.com/mirceaadam/MSCODE-CDE.git && cd MSCODE-CDE
    ```
- after cloning, customize the variables in `user.config`:
    
    [ CONTAINER-SPECIFIC ]
    - CONTAINER_NAME="MY-AWEOSAME-CDE" `#the name that will be displayed in MSCODE`
    - CONTAINER_LOCAL_IMG="mscodecde:latest" `#a random name for your docker image`
   
    [ AWS ]
    - AWS_SETUP="yes"
    - AWS_IAM_USERNAME="john.doe"
    - AWS_TOKEN_DURATION=129600
    
    [ GIT ]
    - GIT_SETUP="yes"
    - GIT_EMAIL="john.doe@company.com"
    - GIT_USERNAME="John Doe"
- If you are using AWS, make sure you have have locally files configured correctly: 
    - in `~/.aws` for linux
    - in `C:\User\your.name\.aws`
- run:
    ```
    chmod +x setup.sh
    bash setup.sh
    cd .. && code .
    ```     

## OTHER INFORMATION
### updates version 3.0:
- credentials security (uses local ~/.aws) + .gitignore
- (!) entrypoint.sh (more versatility)
- simple setup redesign
- local .Dokerfile image

### in the works: 
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