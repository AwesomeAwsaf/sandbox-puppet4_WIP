#Parameter Set: Default
#Set-ExecutionPolicy Unrestricted -Force 2>&1
#Set-ExecutionPolicy Unrestricted -Scope Process
#Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

#Write-Host "running Bootstrap script"
#Write-Host " Rebooting VM"
#Restart-Computer -Force

choco list -la

Write-Host "Running Puppet Agent"
puppet agent --test --verbose
