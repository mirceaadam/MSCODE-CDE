# MS CODE CUSTOM DEVELOPMENT ENVIRONMENT
# MSCODE-CDE v4.0
- It's a custom development environment based on containers so that that it can be easy to share between machines and teams across different operating systems.
- The main goal is to have the same env and same tools in MSCode.
- Current main tools: git, aws-tools(awscli, MFA, ecs, k8s, etc.), cdk v2, etc.

### Main Author
- [Mircea Adam](https://github.com/mirceaadam)

### Contributions
- [Trond Kristiansen](https://github.com)

### Based On
- [Developing Inside A Container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container)

### Requirements

#### HW:
- a decent x86/ARM64, 4-core machine, 16GB RAM for containers

#### OS:
- Have AWS Credentials Configured with profiles in:
    Windows `$HOME\.aws`
    macOS `$HOME/.aws`
    Linux `$HOME/.aws`
- If you do not have AWS Credentials configured:
    - in `common\.aws-example` you have a pre-configured set of credentials that you can inspire
    - or check this: [Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

### INSTALL AND USE
#### Ubuntu-Based Linux & WSL
1. Clone & Change Dir:
```
git clone https://github.com/mirceaadam/MSCODE-CDE.git && cd MSCODE-CDE
```
2. Edit `user.config` with your personal details
```
cd v4/common/user.config && nano user.config
```
3. Run the setup
```
cd ../../wsl && bash setup.sh
```
#### MacOS
#### Dev Containers 
#### Powershell Only
   

### Major Versions 
- Version 4.0 ( June 2023 )
- Version 3.0 ( november 2022 )
- Version 2.0 ( january 2022 )
- Version 1.0 ( november 2021 )