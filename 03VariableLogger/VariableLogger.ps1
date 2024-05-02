<#
.SYNOPSIS
Logs system details and custom messages into a text file and provides user interaction for verification and deletion.

.DESCRIPTION
This script logs system information and user-defined messages to a text file in the script's directory.
After logging, it prompts the user to verify the log contents before automatically deleting the file.

.NOTES
Version:        1.0
Author:         RedBeret
GitHub:         https://github.com/RedBeret
Creation Date:  23APR2024
Last Edit:      29APR2024

.EXAMPLE
To run this script, navigate to the script's directory and execute:
.\VariableLogger.ps1

#>

# Get the current date and time
$todayDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

# Define the file name for output and set the path to the directory of the script
$outputFilePath = Join-Path -Path $PSScriptRoot -ChildPath "VariableLog.txt"

function Log-Data {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Data
    )

    # Check if the log file exists, if not, create it
    if (-not (Test-Path $outputFilePath)) {
        New-Item -Path $outputFilePath -ItemType File
    }

    # Append the data to the log file
    Add-Content -Path $outputFilePath -Value $Data
}

function Log-SystemInfo {
    $systemName = $env:COMPUTERNAME
    $osVersion = [System.Environment]::OSVersion.VersionString
    Log-Data "Log Time: $todayDate"
    Log-Data "System Name: $systemName"
    Log-Data "Operating System: $osVersion"
}

# Log system information
Log-SystemInfo

# Log custom variable
$exampleVariable = "Hello, World in PowerShell!"
Log-Data "Example Variable: $exampleVariable"

# Prompt user to verify the log file
Write-Host "Press Enter to verify the log file and remove it..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

# Verify and remove the log file
if (Test-Path $outputFilePath) {
    Remove-Item $outputFilePath
    Write-Host "The file has been removed."
} else {
    Write-Host "No file found to remove."
}
