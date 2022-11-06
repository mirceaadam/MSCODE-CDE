# MS CODE CUSTOM DEVELOPMENT ENVIRONMENT
# MSCODE-CDE v3.0
### Main Author
- [Mircea Adam](https://github.com/mirceaadam)

### Contributions
- [Trond Kristiansen](https://github.com)

### Based On
- [Developing Inside A Container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container)


## REQUIREMENTS
---------
    - install MSCODE (https://code.visualstudio.com/download)
    - (!) install WSL2 & docker locally on your laptop, link: https://docs.google.com/document/d/1E6XzLu-tamuM6lcvXxd_wgpj7R7L3ufri3f4yFgxDDQ/edit?usp=sharing
    - (!) have your AWS Token prepared
    - prepare or check your ~/.aws folder: credentials & configure
---------

## STEP 0:
- make sure you have have locally ~/.aws files configured correctly
- choose a working directory
- chmod +x setup.sh
- bash setup.sh 

### updates version 3.0:
- credentials security (uses local ~/.aws) + .gitignore
- (!) entrypoint.sh (more versatility)
- simple setup redesign
- local .Dokerfile image
- load extensions(Work in progress)
- example ~/.aws (Work in progress)
- aws configure(?) (Work in progress)
- more aws tools (Work in progress)

### Major Versions 
- Version 3.0 ( november 2022 )
- Version 2.0 ( january 2022 )
- Version 1 (november 2021)