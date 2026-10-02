# AuditClientTools.psm1 - audit folder structure tools. Loads silently.

function New-AuditClient {
    <#
    .SYNOPSIS
    Creates a master client folder with 1000_Permanent_File.
    .EXAMPLE
    New-AuditClient "IBF"
    #>
    param(
        [Parameter(Mandatory = $true)][string]$ClientName,
        [string]$BasePath = (Get-Location),
        [switch]$Help
    )
    if ($Help) { Get-Help $MyInvocation.MyCommand.Name -Examples; return }

    $Root = Join-Path $BasePath $ClientName
    foreach ($f in @(
            "1000_Permanent_File\1100_Legal_Docs",
            "1000_Permanent_File\1200_Policies",
            "1000_Permanent_File\1300_Prior_Year_Summaries"
        )) {
        New-Item -ItemType Directory -Path (Join-Path $Root $f) -Force | Out-Null
    }
    Write-Host "Master client created: $Root" -ForegroundColor Green
}

function New-AuditYear {
    <#
    .SYNOPSIS
    Creates the 3000-series year structure inside a client folder.
    .EXAMPLE
    New-AuditYear ".\IBF" "2025-2026"
    #>
    param(
        [Parameter(Mandatory = $true)][string]$ClientPath,
        [Parameter(Mandatory = $true)][string]$Year,
        [switch]$Help
    )
    if ($Help) { Get-Help $MyInvocation.MyCommand.Name -Examples; return }

    $YearFolder = Join-Path $ClientPath $Year
    $Folders = @(
        "3100_Client_Provided\3110_Trial_Balance",
        "3100_Client_Provided\3120_Ledger",
        "3100_Client_Provided\3130_Bank_Statements",
        "3100_Client_Provided\3140_Salary_Payroll",
        "3100_Client_Provided\3150_Fixed_Assets",
        "3100_Client_Provided\3190_Other",
        "3200_My_Working_Papers\3210_Bank_Confirmations\3211_Sent",
        "3200_My_Working_Papers\3210_Bank_Confirmations\3212_Received",
        "3300_Drafts_and_Reports",
        "3400_Admin_and_Planning"
    )
    foreach ($f in $Folders) {
        New-Item -ItemType Directory -Path (Join-Path $YearFolder $f) -Force | Out-Null
    }
    Write-Host "3000-series structure created for $Year" -ForegroundColor Cyan
}