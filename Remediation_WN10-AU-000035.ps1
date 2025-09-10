<#
.SYNOPSIS
This script ensures that the system must be configured to audit Account Management - User Account Management failures.

.NOTES
    Author          : Levy Borromeo
    LinkedIn        : linkedin.com/in/levyborromeo/
    GitHub          : github.com/levyborromeo
    Date Created    : 2025-09-08
    Last Modified   : 2025-09-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000035

.TESTED ON
    Date(s) Tested  : 2025-09-10
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10-AU-000035.ps1
#>

# Ensure Advanced Audit Policy is enabled for User Account Management (Failure)
auditpol /set /subcategory:"User Account Management" /failure:enable

# Force Group Policy update to apply changes
gpupdate /force

# Verify the configuration
auditpol /get /subcategory:"User Account Management"
