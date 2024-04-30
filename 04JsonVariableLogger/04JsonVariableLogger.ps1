<#
.SYNOPSIS
Logs system and custom variables to a JSON file and allows user verification before deletion.

.DESCRIPTION
This script creates a JSON file to log system details and custom variables. After logging, it prompts
the user to verify the log contents before the file is automatically deleted.

.NOTES
Version:        1.0
Author:         RedBeret
GitHub:         https://github.com/RedBeret
Creation Date:  24APR2024
Last Edit:      29APR2024

.EXAMPLE
To run this script, navigate to the script's directory and execute:
.\04JsonVariableLogger.ps1

#>

# Set script variables
$todayDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
$outputFilePath = Join-Path -Path $PSScriptRoot -ChildPath "VariableLog.json"

function Update-JsonFile {
    param (
        [Parameter(Mandatory=$true)]
        [PSCustomObject]$Data
    )

    $jsonData = $Data | ConvertTo-Json -Depth 5

    # Create or update the JSON file
    Set-Content -Path $outputFilePath -Value $jsonData
}

function Log-SystemInfo {
    $systemName = $env:COMPUTERNAME
    $osVersion = [System.Environment]::OSVersion.VersionString
    $data = [PSCustomObject]@{
        LogTime = $todayDate
        SystemName = $systemName
        OperatingSystem = $osVersion
    }
    Update-JsonFile -Data $data
}

# Main Execution
Log-SystemInfo

$exampleVariable = [PSCustomObject]@{
    ExampleVariable = "Hello, World in PowerShell!"
}
Update-JsonFile -Data $exampleVariable

# Prompt for user verification to view the log file contents
Write-Host "Press Enter to display the log file contents..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

# Display the JSON file contents
$jsonContent = Get-Content -Path $outputFilePath | ConvertFrom-Json
$jsonContent | Format-Table -AutoSize

# Prompt for user verification before deleting the file
Write-Host "Press Enter to remove the log file..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

# Remove the JSON file if it exists
if (Test-Path $outputFilePath) {
    Remove-Item $outputFilePath
    Write-Host "The file has been removed."
} else {
    Write-Host "No file found to remove."
}
