" ....::: Installing MSCode Extensions :::...."
Get-Content ./extensions.txt | ForEach-Object { code --install-extension $_ }