<#
.SYNOPSIS
Simulates the backup process for systems to an ESXi server with input validation and logging.

.DESCRIPTION
This script allows the user to input system details, backup type, and ESXi credentials to simulate backups.
It validates all inputs, securely handles password entry, logs activities, and offers to repeat the process or exit.

.NOTES
Version:        1.0
Author:         RedBeret
GitHub:         https://github.com/RedBeret
Creation Date:  22APR2024
Last Edit:      29APR2024

.EXAMPLE
To run this script, navigate to the script's directory and execute:
.\02BackupSimulator.ps1

#>

# Global variables
$todayDate = (Get-Date).ToString("yyyy-MM-dd")

# Validates if the input is a valid IPv4 address
function IsValidIpAddress {
    param ([string]$address)
    if ($address -match '^((25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.){3}(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)$') {
        return $true
    } else {
        Write-Host "Invalid IP address. Please ensure it is in the format xxx.xxx.xxx.xxx with each octet between 0 and 255." -ForegroundColor Red
        return $false
    }
}

# Validates if the input is a valid hostname
function IsValidHostname {
    param ([string]$hostname)
    if ($hostname -match '^[a-zA-Z][a-zA-Z0-9\-\.]*$' -and $hostname -notlike '*..*') {
        return $true
    } else {
        Write-Host "Invalid hostname. Please enter a valid hostname starting with a letter and not containing consecutive dots." -ForegroundColor Red
        return $false
    }
}

# Gets user input with validation
function Get-ValidatedInput {
    param (
        [string]$prompt,
        [scriptblock]$validationFunction
    )
    do {
        $input = Read-Host $prompt
        if (& $validationFunction $input) {
            return $input
        } else {
            Write-Host "Invalid input. Please try again." -ForegroundColor Red
        }
    } while ($true)
}

# Logs messages to a file
function Log-Message {
    param (
        [string]$Message,
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$Level = "INFO"
    )
    $logPath = Join-Path -Path $env:TEMP -ChildPath "BackupSimulatorLog.txt"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp [$Level] - $Message"
    Add-Content -Path $logPath -Value $logEntry
}

# Confirms the user's password
function Get-ConfirmedPassword {
    do {
        $password = Read-Host "Enter your password for ESXi (input will be hidden)" -AsSecureString
        $confirmPassword = Read-Host "Confirm your password" -AsSecureString

        if ($password -ceq $confirmPassword) {
            Write-Host "Password confirmed." -ForegroundColor Green
            return $password
        } else {
            Write-Host "Passwords do not match. Please try again." -ForegroundColor Red
        }
    } while ($true)
}

# Handles the backup process
function Invoke-BackupProcess {
    $system = Get-ValidatedInput "Enter the system name" ${function:IsValidHostname}
    $type = Get-ValidatedInput "Enter the type of backup (e.g., full, incremental)" ${function:IsValidHostname}
    $esxiIP = Get-ValidatedInput "Enter the IP address for ESXi" ${function:IsValidIpAddress}
    $username = Read-Host "Enter your username for ESXi"
    $password = Get-ConfirmedPassword

    $backupName = "$system-$type-$todayDate"
    Log-Message "Starting backup for $backupName on ESXi at $esxiIP" "INFO"

    Start-Sleep -Seconds 5  # Simulate backup process
    Log-Message "Backup completed successfully for $backupName" "INFO"
    Write-Host "Backup completed successfully."

    if ((Read-Host "Backup is done, do you want to exit? (yes/no)") -eq "yes") {
        Write-Host "Exiting the script."
        exit
    }
}

# Main execution loop
while ($true) {
    Invoke-BackupProcess
}
