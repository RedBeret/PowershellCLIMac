<#
.SYNOPSIS
Creates or updates a JSON log file based on system and custom variables.

.DESCRIPTION
Logs specific variables to a JSON file within the script's directory. The script checks if the file
was created or last updated within the last 7 days and skips creating or updating to minimize
redundant writes. It provides functionality to delete the log file after user review.

.NOTES
Version:        1.0
Author:         RedBeret
GitHub:         https://github.com/RedBeret
Creation Date:  25APR2024
Last Edit:      29APR2024

.EXAMPLE
To run this script, navigate to the script's directory and execute:
.\ScriptName.ps1

#>

# Set script variables
$currentDateTime = Get-Date
$currentDateTimeFormatted = $currentDateTime.ToString("yyyy-MM-dd HH:mm:ss")
$logFilePath = Join-Path -Path $PSScriptRoot -ChildPath "SystemLog.json"

function CreateOrUpdateJsonLog {
    param ([PSCustomObject]$Data)

    $jsonData = $Data | ConvertTo-Json -Depth 5

    if (Test-Path $logFilePath) {
        $fileLastWriteTime = (Get-Item $logFilePath).LastWriteTime

        # Check if the file was updated within the last 7 days
        if ((New-TimeSpan -Start $fileLastWriteTime -End $currentDateTime).Days -lt 7) {
            Write-Host "JSON log file is up-to-date and was updated within the last week. Skipping update."
            return
        }
    }

    Set-Content -Path $logFilePath -Value $jsonData
    Write-Host "JSON log file has been updated or created."
}

function RecordSystemDetails {
    $systemName = $env:COMPUTERNAME
    $osVersion = [System.Environment]::OSVersion.VersionString
    $data = [PSCustomObject]@{
        LogTime = $currentDateTimeFormatted
        SystemName = $systemName
        OperatingSystem = $osVersion
    }
    CreateOrUpdateJsonLog -Data $data
}

RecordSystemDetails

$exampleVariable = [PSCustomObject]@{
    ExampleVariable = "Hello, World in PowerShell!"
}
CreateOrUpdateJsonLog -Data $exampleVariable

Write-Host "Press Enter to display the log file contents..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

if (Test-Path $logFilePath) {
    $jsonContent = Get-Content -Path $logFilePath | ConvertFrom-Json
    $jsonContent | Format-Table -AutoSize
}

Write-Host "Press Enter to remove the log file after verification..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

if (Test-Path $logFilePath) {
    Remove-Item $logFilePath
    Write-Host "The log file has been successfully removed."
} else {
    Write-Host "No log file found to remove."
}
