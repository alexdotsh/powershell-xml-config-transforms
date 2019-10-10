If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

$xdoc = new-object System.Xml.XmlDocument

$file = resolve-path(".\LogicalTest.ServiceProcess.config")

$xdoc.load($file)

[xml] $xdoc = get-content ".\LogicalTest.ServiceProcess.config"

$xdoc = [xml] (get-content ".\LogicalTest.ServiceProcess.config")

