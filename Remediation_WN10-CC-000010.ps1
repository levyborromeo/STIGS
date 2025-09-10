<#
.SYNOPSIS
This script ensures that the display of slide shows on the lock screen is disabled.

.NOTES
    Author          : Levy Borromeo
    LinkedIn        : linkedin.com/in/levyborromeo/
    GitHub          : github.com/levyborromeo
    Date Created    : 2025-09-10
    Last Modified   : 2025-09-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 2025-09-10
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10-CC-000010.ps1
#>

# Define the registry path and required values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$registryName = "NoLockScreenSlideshow"
$expectedValue = 1  # 1 = Disabled, 0 = Enabled

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    Write-Host "Registry path not found. Creating path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Get the current value of the setting
$currentValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName

# Apply the setting if not already set
if ($currentValue -ne $expectedValue) {
    Write-Host "Disabling slide shows on the lock screen..."
    Set-ItemProperty -Path $registryPath -Name $registryName -Value $expectedValue -Type DWord
    Write-Host "Lock screen slide shows have been disabled successfully."
} else {
    Write-Host "Lock screen slide shows are already disabled."
}

# Verify the change
$updatedValue = (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue).$registryName
Write-Host "Current policy value: $updatedValue (Expected: $expectedValue)"



