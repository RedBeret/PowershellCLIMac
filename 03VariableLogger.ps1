# VariableLogger.ps1
# Script to log specific variables to a file in the same directory as the script,
# with a prompt to hit enter to verify and then remove the file.

# Get the current date and time
$todayDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

# Define the file name for output and set the path to the directory of the script
$outputFilePath = Join-Path -Path $PSScriptRoot -ChildPath "VariableLog.txt"

# Function to log data to a file
function Log-Data {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Data
    )

    # Ensure the file path exists and then log the data
    if (-not (Test-Path $outputFilePath)) {
        New-Item -Path $outputFilePath -ItemType File
    }

    # Append the data to the log file
    Add-Content -Path $outputFilePath -Value $Data
}

# Function to log system-related variables or operations
function Log-SystemInfo {
    $systemName = $env:COMPUTERNAME
    $osVersion = [System.Environment]::OSVersion.VersionString
    Log-Data "Log Time: $todayDate"
    Log-Data "System Name: $systemName"
    Log-Data "Operating System: $osVersion"
}

# Main Execution
Log-SystemInfo

# Log custom variables or perform operations
$exampleVariable = "Hello, World in PowerShell!"
Log-Data "Example Variable: $exampleVariable"

# Pause for user to verify the file's existence and contents
Write-Host "Press Enter to verify the log file and remove it..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

# Check if the file exists and remove it
if (Test-Path $outputFilePath) {
    Remove-Item $outputFilePath
    Write-Host "The file has been removed."
} else {
    Write-Host "No file found to remove."
}
