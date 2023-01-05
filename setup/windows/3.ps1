#This script continues to install the devops environment with docker containers.

" "
" ....::: DevOps Container Setup Part II :::...."
"Again, I am removing myself from ScheduledTasks.. Thanx Windows ;) "
$TaskName2 = "devopsEnvironmentInstaller2"
$docker_executable = "C:\Program Files\Docker\Docker\Docker Desktop.exe"
schtasks /delete /tn $TaskName2 /F 2>$null

"Starting Docker.. Follow instructions in the wizard"
Start-Process $docker_executable

"Now go to https://www.youtube.com/watch?v=dQw4w9WgXcQ"
"Good day."