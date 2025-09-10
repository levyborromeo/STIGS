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
    STIG-ID         : WN10-00-000107

.TESTED ON
    Date(s) Tested  : 2025-09-10
    Tested By       : Levy Borromeo
    Systems Tested  : Windows 10 Pro VM 
    PowerShell Ver. : PowerShell Version: 5.1.19041.6328

.USAGE
    PS C:\> .\Remediation_WN10-AU-000081.ps1
#>

# Define the audit policy category and subcategory
$auditCategory = "Object Access"
$auditSubcategory = "File Share"

# Check current audit settings
$currentAuditSetting = auditpol /get /subcategory:"$auditSubcategory" | Select-String "Failure"

# If auditing is not enabled, configure it
if ($currentAuditSetting -notmatch "Failure") {
    Write-Host "Enabling auditing for File Share failures..."
    auditpol /set /subcategory:"$auditSubcategory" /failure:enable
    Write-Host "File Share failure auditing has been enabled."
} else {
    Write-Host "File Share failure auditing is already enabled."
}

# Verify the change
$updatedAuditSetting = auditpol /get /subcategory:"$auditSubcategory"
Write-Host "Current Audit Policy for ${auditSubcategory}:`n$updatedAuditSetting"

