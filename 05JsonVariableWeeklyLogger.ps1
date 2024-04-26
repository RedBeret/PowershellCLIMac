# Script to log specific variables to a JSON file in the same directory as the script,
# checks if file created today or this week then skips creation, allows deletion at the end if complete.

# Get the current date and time
$currentDateTime = Get-Date
$currentDateTimeFormatted = $currentDateTime.ToString("yyyy-MM-dd HH:mm:ss")

# Define the file name for output and set the path to the directory of the script
$logFilePath = Join-Path -Path $PSScriptRoot -ChildPath "SystemLog.json"

# Function to create or update the JSON file with data, only if it doesn't exist or isn't recent
function CreateOrUpdateJsonLog {
    param (
        [Parameter(Mandatory=$true)]
        [PSCustomObject]$Data
    )

    # Convert data to JSON
    $jsonData = $Data | ConvertTo-Json -Depth 5

    # Check if file exists and when it was created
    if (Test-Path $logFilePath) {
        $fileCreationDate = (Get-Item $logFilePath).CreationTime

        # Check if the file was created today or this week
        if ($fileCreationDate -ge $currentDateTime.Date -or ($currentDateTime - $fileCreationDate).Days -lt 7) {
            Write-Host "JSON log file is up-to-date and was created within this week. Skipping update."
            return
        }
    }

    # File does not exist or is old, create or update
    Set-Content -Path $logFilePath -Value $jsonData
    Write-Host "JSON log file updated or created."
}

# Function to log system-related variables or operations
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

# Main Execution
RecordSystemDetails

# Log custom variables or perform operations
$exampleVariable = [PSCustomObject]@{
    ExampleVariable = "Hello, World in PowerShell!"
}
CreateOrUpdateJsonLog -Data $exampleVariable

# Pause for user to verify the file's contents
Write-Host "Press Enter to display the log file contents..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

# Read and display the JSON file contents if exists
if (Test-Path $logFilePath) {
    $jsonContent = Get-Content -Path $logFilePath | ConvertFrom-Json
    $jsonContent | Format-Table -AutoSize
}

# Pause for user to verify before deleting the file
Write-Host "Press Enter to remove the log file..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

# Check if the file exists and remove it
if (Test-Path $logFilePath) {
    Remove-Item $logFilePath
    Write-Host "The log file has been removed."
} else {
    Write-Host "No log file found to remove."
}
