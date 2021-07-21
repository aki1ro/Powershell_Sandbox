'''
Cmdlets = Windows powershell commands that are written in a compiled .NET programming language (ie: VB, C#)

Functions = Windows powershell commands that are written natively in Windows powershell

Workflows = long-running, durable PowerShell commands that can survive system restarts and respond to other environmental changes

Configurations = Windows powershell scripts that orchestrate Desired State Configuration (DSC) settings

Classes = PowerShell v5 gives us the ability to create honest-to-goodness .NET classes, which are code blocks that provude a specific interface

In Windows PowerShell nomenclature, a snap-in is a compiled Dynamic Link Library (DLL) that contains PowerShell commands. The potential problem with snap-ins is they must be registered (installed) on a system before use and implments cmdlets and Windows Powershell providers. To add snap-ins use: "Add-PSSnapin and to remove: "Remove-PSSnapin"
'''


$A = 3

$B = 2

$A + $B


$Host #Host information

# Get-Host <---- gets information about your powershell host

# Get-EventLog  -List #gets event log list

# Stop-service Spooler -WhatIf # WhatIf parses the command and lets you know what it does


# Get-Item -Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\*" #Gets current .net framework version


# $PSVersionTable.PSVersion # Gets current version of powershell

# Get-Command -Noun A* # Retrieves all commands that match the -noun

# Update-Help -Force # updates the help database

Write-Host $env:PSModulePath # use write-host to print to terminal



