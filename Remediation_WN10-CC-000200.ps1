<#
.SYNOPSIS
This script ensures that Administrator accounts is not enumerated during elevation.

.NOTES
    Author          : Levy Borromeo
    LinkedIn        : linkedin.com/in/levyborromeo/
    GitHub          : github.com/levyborromeo
    Date Created    : 2025-09-11
    Last Modified   : 2025-09-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000200

.TESTED ON
    Date(s) Tested  : 2025-09-11
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10-CC-000200.ps1
#>

# Define the registry path and required values
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$registryName = "EnumerateAdministrators"
$expectedValue = 0  # 0 = Do not enumerate admin accounts, 1 = Enumerate admin accounts

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    Write-Host "Registry path not found. Creating path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Get the current value of the setting
$currentValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName

# Apply the setting if not already set
if ($currentValue -ne $expectedValue) {
    Write-Host "Disabling administrator account enumeration during elevation..."
    Set-ItemProperty -Path $registryPath -Name $registryName -Value $expectedValue -Type DWord
    Write-Host "Administrator account enumeration has been disabled successfully."
} else {
    Write-Host "Administrator account enumeration is already disabled."
}

# Verify the change
$updatedValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName
Write-Host "Current policy value: $updatedValue (Expected: $expectedValue)"
