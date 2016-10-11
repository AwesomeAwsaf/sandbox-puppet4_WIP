Parameter Set: Default
Set-ExecutionPolicy Unrestricted -Force 2>&1
Set-ExecutionPolicy Unrestricted -Scope Process
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
Disable-InternetExplorerESC #useful to get rid of the annoying IE security on Windows server

$SysInfo = Get-WmiObject Win32_ComputerSystem
$SysInfo.JoinDomainOrWorkgroup("awezone.com")

Write-Host 'Adding puppet (10.10.10.10) to hosts file.'
Add-Content $env:SystemDrive\Windows\System32\Drivers\etc\hosts "`r`n10.10.10.10     puppet"

#Restart-Computer
choco list -la
#choco install puppet-agent -version 1.2.5 -y
#choco list -la

#puppet agent --test --verbose
Import-Module ServerManager

$features = @(
    "Web-WebServer", 
    "Web-Static-Content",
    "Web-Http-Errors",
    "Web-Http-Redirect",
    "Web-Stat-Compression",
    "Web-Filtering",
    "Web-Asp-Net45",
    "Web-Net-Ext45",
    "Web-ISAPI-Ext",
    "Web-ISAPI-Filter",
    "Web-Mgmt-Console",
    "Web-Mgmt-Tools",
    "NET-Framework-45-ASPNET")

Add-WindowsFeature $features -Verbose

cinst IIS-WebServerRole -source windowsfeatures
cinst IIS-HttpCompressionDynamic -source windowsfeatures
cinst IIS-ManagementScriptingTools -source windowsfeatures
cinst IIS-WindowsAuthentication -source windowsfeatures
cinst DotNet3.5 # Not automatically installed
if (Test-PendingReboot) { Invoke-Reboot }