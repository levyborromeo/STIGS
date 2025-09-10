<#
.SYNOPSIS
This script ensures that printing over HTTP must be prevented.

.NOTES
    Author          : Levy Borromeo
    LinkedIn        : linkedin.com/in/levyborromeo/
    GitHub          : github.com/levyborromeo
    Date Created    : 2025-09-11
    Last Modified   : 2025-09-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000110

.TESTED ON
    Date(s) Tested  : 2025-09-11
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10-CC-000110.ps1
#>

# Define the registry path and required values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$registryName = "DisableHTTPPrinting"
$expectedValue = 1  # 1 = HTTP Printing Disabled, 0 = Enabled

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    Write-Host "Registry path not found. Creating path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Get the current value of the setting
$currentValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName

# Apply the setting if not already set
if ($currentValue -ne $expectedValue) {
    Write-Host "Disabling printing over HTTP..."
    Set-ItemProperty -Path $registryPath -Name $registryName -Value $expectedValue -Type DWord
    Write-Host "Printing over HTTP has been disabled successfully."
} else {
    Write-Host "Printing over HTTP is already disabled."
}

# Verify the change
$updatedValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName
Write-Host "Current policy value: $updatedValue (Expected: $expectedValue)"

