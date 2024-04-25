# VariableLogger.ps1
# Script to log specific variables to a JSON file in the same directory as the script,
# with a prompt to hit enter to verify, itll print and then remove the file.

# Get the current date and time
$todayDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

# Define the file name for output and set the path to the directory of the script
$outputFilePath = Join-Path -Path $PSScriptRoot -ChildPath "VariableLog.json"

# Function to create or update the JSON file with data
function Update-JsonFile {
    param (
        [Parameter(Mandatory=$true)]
        [PSCustomObject]$Data
    )

    # Convert data to JSON
    $jsonData = $Data | ConvertTo-Json -Depth 5

    # Check if file exists, if not, create a new JSON file
    if (-not (Test-Path $outputFilePath)) {
        New-Item -Path $outputFilePath -ItemType File
    }

    # Write JSON data to file
    Set-Content -Path $outputFilePath -Value $jsonData
}

# Function to log system-related variables or operations
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

# Log custom variables or perform operations
$exampleVariable = [PSCustomObject]@{
    ExampleVariable = "Hello, World in PowerShell!"
}
Update-JsonFile -Data $exampleVariable

# Pause for user to verify the file's contents
Write-Host "Press Enter to display the log file contents..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

# Read and display the JSON file contents
$jsonContent = Get-Content -Path $outputFilePath | ConvertFrom-Json
$jsonContent | Format-Table -AutoSize

# Pause for user to verify before deleting the file
Write-Host "Press Enter to remove the log file..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

# Check if the file exists and remove it
if (Test-Path $outputFilePath) {
    Remove-Item $outputFilePath
    Write-Host "The file has been removed."
} else {
    Write-Host "No file found to remove."
}
