<#
.SYNOPSIS
This script ensures that Windows 10 systems uses a BitLocker PIN for pre-boot authentication.

.NOTES
    Author          : Levy Borromeo
    LinkedIn        : linkedin.com/in/levyborromeo/
    GitHub          : github.com/levyborromeo
    Date Created    : 2025-09-11
    Last Modified   : 2025-09-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10–00–000031

.TESTED ON
    Date(s) Tested  : 2025-09-11
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10–00–000031.ps1
#>

# Define registry path for BitLocker policies
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set UseAdvancedStartup to 1 (Enable advanced startup options for BitLocker)
Set-ItemProperty -Path $RegPath -Name "UseAdvancedStartup" -Value 1 -Type DWord

# Set UseTPMPIN to 1 (Require startup PIN with TPM)
Set-ItemProperty -Path $RegPath -Name "UseTPMPIN" -Value 1 -Type DWord

# Set UseTPMKeyPIN to 1 (Require startup key and PIN with TPM)
Set-ItemProperty -Path $RegPath -Name "UseTPMKeyPIN" -Value 1 -Type DWord

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
Get-ItemProperty -Path $RegPath -Name UseAdvancedStartup, UseTPMPIN, UseTPMKeyPIN
