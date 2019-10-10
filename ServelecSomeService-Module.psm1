If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

param (
    [Parameter(Mandatory=$true)][string]$systemConnectionName,
    [Parameter(Mandatory=$true)][string]$systemConnectionString,
    [Parameter(Mandatory=$true)][string]$globalConnectionName,
    [Parameter(Mandatory=$true)][string]$globalConnectionString,
    [Parameter(Mandatory=$true)][string]$monitoredSystemName,
    [string]$logLevel = '',
    [string]$endpointAddress = ''
)

[xml] $xdoc = get-content ".\LogicalTest.ServiceProcess.config"

# Constructor args
$xdoc.configuration.spring.services.objects.object.'constructor-arg'.list

# System configuration - parameter mandatory
$xdoc.configuration.SystemConnections.Connections.SystemConnection.Name             = $systemConnectionName
$xdoc.configuration.SystemConnections.Connections.SystemConnection.ConnectionString = $systemConnectionString

# Global configuration - parameter mandatory
$xdoc.configuration.GlobalConnections.Connections.GlobalConnection.Name             = $globalConnectionName
$xdoc.configuration.GlobalConnections.Connections.GlobalConnection.ConnectionString = $globalConnectionString
$xdoc.configuration.GlobalConnections.Connections.GlobalConnection.MonitoredSystems.MonitoredSystem.name = $monitoredSystemName

# LogLevel - parameter optional
if ($logLevel) {
    $xdoc.configuration.log4net.root.level.value = $logLevel
}

# Endpoint  - parameter optional
if ($endpointAddress) {
    $xdoc.configuration.'system.serviceModel'.client.endpoint.address = $endpointAddress
}

# Save
$xdoc.Save(".\LogicalTest.ServiceProcess.updated.config")
