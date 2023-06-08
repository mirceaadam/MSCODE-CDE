function Render-Minimal {
    Write-Host " "
    Write-Host "     ... :: Minimal Setup ::: ... "
    Write-Host " "
    Write-Host " Mandatory: "
    Write-Host "    Amazon.AWSCLI (winget:mandatory)"
    Write-Host "    $HOME/.aws/getToken.ps1 (script:mandatory) + added in ENV"
    Write-Host " Optional: "
    Write-Host "    Python.Python.3.11 (winget:optional)
                    Git.Git (winget:optional)
                    vscode (winget:optional)
                    vscode-extensions (script:optional)
                    code-commit-helper (script:optional)    
                    cfn-lint (script:optional) "

}


#awscli (winget)
$scripts = Get-ChildItem -Path $PacketManagersFolder -Filter "*.ps1" | Sort-Object

foreach ($script in $scripts) {
    Write-Host "Running script: $($script.Name)"
    & $script.FullName
    Write-Host "Script completed: $($script.Name)`n"
}