# MS CODE CUSTOM DEVELOPMENT ENVIRONMENT
# MSCODE-CDE v3.0

#### What is this?
- It's a custom development environment based on containers so that that it can be easly be shared between machines and teams on different operating systems.
- The main goal is to have the same env and same tools in MSCode.

### Status
- ![Test passing](https://img.shields.io/badge/Tests-passing-brightgreen.svg)

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
#### M1 Mac
    - install docker desktop
    - install [MSCODE](https://code.visualstudio.com/download)
#### Linux / Ubuntu / Debians
    - install docker desktop
    - install [MSCODE](https://code.visualstudio.com/download)

## INSTALATION / USAGE
- make sure you have have locally ~/.aws files configured correctly
- choose a working directory
- chmod +x setup.sh
- bash setup.sh 

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