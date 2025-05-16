#GLOBALS
$packageName = "openssh"

function GenerateSSHKeyPair {
    
        Write-Host "Starting the gen process.."
        $input_email = Read-Host "Enter your email address: "
        Write-Host "Using: $input_email"
        Write-Host " "
        Write-Host " " 
        Write-Host "Hint: Just hit << ENTER >> for all questions."
        Write-Host " "
        Write-Host " "
        ssh-keygen -t rsa -b 4096 -C "$input_email"
    }

function DisplayHelp {  
    Write-Host " "
    Write-Host " "
    Write-Host " Generation Completed. "
    Write-Host "NEXT - Visit: https://gitlab.company.xyz/-/user_settings/ssh_keys"
    Write-Host " "
    Write-Host " Add the full contents from the opened notepad to the << KEY >> section in GitLab SSH Keys under your $USER user profile. "    
    notepad "C:\Users\$USER\.ssh\id_rsa.pub"
    Write-Host " "
    Write-Host "(!) If above failed, visit: https://docs.gitlab.com/user/ssh/#generate-an-ssh-key-pair"
}

GenerateSSHKeyPair
DisplayHelp