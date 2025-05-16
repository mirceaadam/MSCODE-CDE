#GLOBALS
$packageName = "openssh"

function GenerateSSHKeyPair {
    
        Write-Host "Starting the gen process.."
        $input_email = Read-Host "Enter your email address"
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
    Write-Host " "
    Write-Host "     --- QUICK GUIDE IN GITLAB ---   "
    Write-Host "1. Logon to gitlab with $USER and your AD Pass."
    Write-Host "2. Click your user Icon in the left hand side -> Click << Preferences >> . "
    Write-Host "3. In the left menu, click << SSH Keys >> ."
    Write-Host "4. Right: Press << Add new key >> button."
    Write-Host "5. Add the key from notepad that automatically opened.."
    Write-Host " "
    Write-Host " "
    notepad "C:\Users\$USER\.ssh\id_rsa.pub"
    Write-Host " "
    Write-Host " "
    Write-Host "(!) If above failed, visit: https://docs.gitlab.com/user/ssh/#generate-an-ssh-key-pair"
    Write-Host "     --- END ---   "
}

GenerateSSHKeyPair
DisplayHelp