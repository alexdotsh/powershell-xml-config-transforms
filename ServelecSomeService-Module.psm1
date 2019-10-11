param (
    [string]$value1 = '',
    [string]$value2 = '',
    [Parameter(Mandatory=$true)][string]$systemConnectionName,
    [Parameter(Mandatory=$true)][string]$systemConnectionString,
    [Parameter(Mandatory=$true)][string]$globalConnectionName,
    [Parameter(Mandatory=$true)][string]$globalConnectionString,
    [Parameter(Mandatory=$true)][string]$monitoredSystemName,
    [string]$logLevel = '',
    [string]$endpointAddress = ''
)

# Read xml file
[xml] $xdoc = get-content ".\LogicalTest.ServiceProcess.config"

# Constructor args
$num = 1
Foreach ($list in $xdoc.SelectNodes("//configuration/spring/services/objects/object/constructor-arg/list")) {
    Foreach ($value in $list.value) {
        $elem = "value" + $num
        if ($elem) {
            $value = $elem
            Write-host $($elem)
        }
    $Script:num++
    }
}

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

function Set-ClientCredentialType {
    Get-ClientCredentialType 

    if ($Chosentype == 'None') {
        Set-HttpBinding
    }

    if ($Chosentype == 'Windows') {
        Set-HttpBinding -securityMode 'Transport' -clientCredentialType 'Windows'
    }

    if ($Chosentype == 'Username') {
        Set-HttpBinding -securityMode 'Transport' -clientCredentialType 'Username'
    }

    if ($Chosentype == 'Certificate') {
        Set-HttpBinding -securityMode 'Transport' -clientCredentialType 'Certificate'
    }

    if ($Chosentype == 'Issued Token') {
        Set-HttpBinding -securityMode 'Transport' -clientCredentialType 'Issued Token'
    }
}

function Get-ClientCredentialType {
    Show-Menu

	$selection = Read-Host "Please make a selection"
	Switch ($selection) {
		1 { $Chosentype = 'None' }
		2 { $Chosentype = 'Windows' }
		3 { $Chosentype = 'Username' }
        4 { $Chosentype = 'Certificate' }
        5 { $Chosentype = 'Issued Token' }
	}
}

function Show-Menu {
    Write-Host "================ Menu ================"
    Write-Host "1: Press '1' to select 'None'"
    Write-Host "2: Press '2' to 'Windows'"
    Write-Host "3: Press '3' to 'Username'"
    Write-Host "4: Press '4' to 'Certificate'"
    Write-Host "5: Press '5' to 'Issued Token'"
}

function Set-HttpBinding {
    param (
        [string]$securityMode = 'None'
        [string]$clientCredentialType = 'None'
    )

    $xdoc.configuration.'system.serviceModel'.bindings.basicHttpBinding.binding.security.mode = $securityMode
    $xdoc.configuration.'system.serviceModel'.bindings.basicHttpBinding.binding.security.transport.clientCredentialType = $clientCredentialType
}

# Endpoint  - parameter optional
if ($endpointAddress) {
    $xdoc.configuration.'system.serviceModel'.client.endpoint.address = $endpointAddress
}

# Save
$xdoc.Save(".\LogicalTest.ServiceProcess.updated.config")
