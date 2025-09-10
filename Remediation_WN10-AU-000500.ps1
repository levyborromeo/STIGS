<#
.SYNOPSIS
This script ensures that the Application event log size is configured to 32768 KB or greater.

.NOTES
    Author          : Levy Borromeo
    LinkedIn        : linkedin.com/in/levyborromeo/
    GitHub          : github.com/levyborromeo
    Date Created    : 2025-09-10
    Last Modified   : 2025-09-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2025-09-10
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10-AU-000500.ps1
#>

# Define registry path for Application Event Log Policy
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set the Maximum Log Size (KB) to 32,768
Set-ItemProperty -Path $RegPath -Name "MaxSize" -Value 32768 -Type DWord

# Enable the policy by ensuring the setting is applied via Group Policy
gpupdate /force

# Verify the configuration

Get-ItemProperty -Path $RegPath -Name "MaxSize"
