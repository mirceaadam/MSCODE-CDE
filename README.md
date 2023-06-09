# MS CODE CUSTOM DEVELOPMENT ENVIRONMENT
# MSCODE-CDE

- The main goal is to have the same env quickly reinstalled and same tools in MSCode.
- It's a custom development environment based on containers so that that it can be easy to share between machines and teams across different operating systems.
- Current main tools: git, aws-tools(awscli, MFA, ecs, k8s, etc.), cdk v2, etc.

### Requirements
#### HW:
- a decent x86/ARM64 minimum 4-core machine, 16GB RAM for containers
- decent internet access
#### OS:
- administrator / root access
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
nano v4/common/user.config
```
3. Run the setup
```
bash v4/wsl/setup.sh
```
#### MacOS
#### Dev Containers 
#### Windows

1. Open Powershell AS ADMINISTRATOR
2. RUN the following commands in succesion:
```
mkdir C:\Temp\CDE
cd C:\Temp\CDE
Invoke-WebRequest -Uri "https://github.com/mirceaadam/MSCODE-CDE/archive/refs/heads/main.zip" -OutFile "C:\Temp\CDE\MSCODE-CDE.zip"
Expand-Archive -Path "./MSCODE-CDE.zip" -DestinationPath "./MSCODE-CDE"
```
Next, RUN the following two commands with 
**[A] - YES TO ALL !** :
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine 
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
Let's start the windows setup:
``` 
cd C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main\v4\windows
.\setup.ps1
```
### Notes and Known Bugs:

    - When the installation finishes, you must open a separate powershell/cmd to use the tools !

    - Do not forget to install you VSCode extensions with this command:
    ```
    Start-Process Powershell C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main\v4\common\extensions\extensions.ps1 -wait
    ```

### Main Author
- [Mircea Adam](https://github.com/mirceaadam)

### Contributions
- [ChatGPT4](https://chat.openai.com/)
- [devops Team](https://google.com)
- [Trond Kristiansen](https://github.com) //access docker socket from container

### Based On
- [Developing Inside A Container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container)

### Version 4 features
Cross-Platform:
- re-written with solid base to promote modularity, easy install and maintenance.
    - credentials
    - getToken available system-wide
    - getToken script improved
- vscode extensions 

Windows:
- fixed anoying Windows Path Variables in `[EnvironmentVariableTarget]::User` 
- use of netget(90%), chocolately, nuget or custom scripts.
- installation options: 
    - awscli-only (getToken+)
    - minimal 
    - full(WSL+Docker)  

WSL:
- ready to configure with awscli+WSL+getToken
- software & tools

Container:
- easy to maintain, configure and set-up
### Major Versions 
- Version 4.0 ( June 2023 )
- Version 3.0 ( november 2022 )
- Version 2.0 ( january 2022 )
- Version 1.0 ( november 2021 )