<#
.SYNOPSIS
This script ensures that the machine inactivity limit is set to 15 minutes, locking the system with the screensaver.

.NOTES
    Author          : Levy Borromeo
    LinkedIn        : linkedin.com/in/levyborromeo/
    GitHub          : github.com/levyborromeo
    Date Created    : 2025-09-11
    Last Modified   : 2025-09-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070

.TESTED ON
    Date(s) Tested  : 2025-09-11
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10-SO-000070.ps1
#>

# Define the registry path and required values
$registryPath = "HKCU:\Control Panel\Desktop"
$screenSaverActive = "ScreenSaverActive"
$screenSaveTimeOut = "ScreenSaveTimeOut"
$screenSaverSecure = "ScreenSaverIsSecure"
$expectedTimeout = 900  # 15 minutes (900 seconds)

# Ensure the screen saver is active
Set-ItemProperty -Path $registryPath -Name $screenSaverActive -Value "1"

# Set the screen saver timeout to 15 minutes
Set-ItemProperty -Path $registryPath -Name $screenSaveTimeOut -Value "$expectedTimeout"

# Ensure the system locks when the screen saver activates
Set-ItemProperty -Path $registryPath -Name $screenSaverSecure -Value "1"

Write-Host "Screen saver timeout and lock settings have been configured successfully."

# Verify the changes
$timeoutSet = Get-ItemProperty -Path $registryPath -Name $screenSaveTimeOut
Write-Host "Current Timeout: $($timeoutSet.ScreenSaveTimeOut) seconds (Expected: 900 seconds)"
