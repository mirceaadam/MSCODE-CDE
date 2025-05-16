# MS CODE CUSTOM DEVELOPMENT ENVIRONMENT


- The main goal is to have the same env quickly reinstalled and same tools in MSCode.
- It's a custom development environment 

# Installation

#### Windows


1. Open an Elevated Powershell (**As Administrator**)
2. RUN the following full command to start the script:

```powershell
PowerShell.exe -Command "mkdir C:\Temp\CDE; cd C:\Temp\CDE; Invoke-WebRequest -Uri 'https://github.com/mirceaadam/MSCODE-CDE/archive/refs/heads/main.zip' -OutFile 'C:\Temp\CDE\MSCODE-CDE.zip'; Expand-Archive -Path './MSCODE-CDE.zip' -DestinationPath './MSCODE-CDE'; Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine; Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; cd C:\Temp\CDE\MSCODE-CDE\MSCODE-CDE-main\v4\windows; .\setup.ps1"
```

### Quick MENU process.
- Type **ignore** at sript start (if 1st time user or you lost your `.aws` folder)
- Type **win**
- Install OPTIONAL Also ?  `y` or `n`

` !!! Observations`: 

### Main Author
- [Mircea Adam](https://github.com/mirceaadam)

### Contributions
- AI Support
- [devops Team](https://google.com)
- [Trond Kristiansen](https://github.com) //access docker socket from container

### Based On
- [Developing Inside A Container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container)


### Major Versions
- Version 4.8 ( May 2024 ) 
- Version 4.0 ( June 2023 )
- Version 3.0 ( november 2022 )
- Version 2.0 ( january 2022 )
- Version 1.0 ( november 2021 )

