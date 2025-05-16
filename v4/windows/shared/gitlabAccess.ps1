#GLOBALS
$packageName = "openssh"

function GenerateSSHKeyPair {
    
        Write-Host "Starting the gen process.." 
        Write-Host "Just hit ENTER for all questions."
        Start-Process ssh-keygen -t rsa -b 2048 -C "$USER GitlabAccess Key" -Wait
    }

function DisplayHelp {  
    Write-Host "Visit https://gitlab.company.xyz/-/user_settings/ssh_keys and add the from notepad."
    Start-Process notepad "C:\Users\$USER\.ssh\id_rsa.pub"
    Write-Host "(!) If above failed, visit: https://docs.gitlab.com/user/ssh/#generate-an-ssh-key-pair"
}

GenerateSSHKeyPair
DisplayHelp