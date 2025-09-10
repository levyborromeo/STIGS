<#
.SYNOPSIS
This script ensures that Camera access from the lock screen is disabled.

.NOTES
    Author          : Levy Borromeo
    LinkedIn        : linkedin.com/in/levyborromeo/
    GitHub          : github.com/levyborromeo
    Date Created    : 2025-09-10
    Last Modified   : 2025-09-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 2025-09-10
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10-CC-000005.ps1
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Check if the device has a camera
$CameraExists = Get-PnpDevice -Class Camera -ErrorAction SilentlyContinue

if ($CameraExists) {
    # Ensure the registry path exists
    If (!(Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force
    }

    # Set the NoLockScreenCamera value to 1 (Disable lock screen camera)
    Set-ItemProperty -Path $RegPath -Name "NoLockScreenCamera" -Value 1 -Type DWord

    # Force Group Policy update to apply changes
    gpupdate /force

    # Verify the configuration
    Get-ItemProperty -Path $RegPath -Name "NoLockScreenCamera"
} else {
    Write-Output "No camera detected. This setting is Not Applicable (NA)."

}
