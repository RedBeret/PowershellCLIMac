# Declare global variables
$todayDate = (Get-Date).ToString("yyyy-MM-dd")

# Function to validate if the provided string is a valid IP address
function IsValidIpAddress($address) {
    # Regular expression matches standard IPv4 addresses from 0.0.0.0 to 255.255.255.255
    if ($address -match '^((25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.){3}(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)$') {
        return $true
    } else {
        Write-Host "Invalid IP address. Please ensure it is in the format xxx.xxx.xxx.xxx with each octet between 0 and 255." -ForegroundColor Red
        return $false
    }
}

# Function to validate if the provided string is a valid hostname
function IsValidHostname($hostname) {
    # Regular expression matches hostnames that start with a letter and may include digits, dashes, or dots
    if ($hostname -match '^[a-zA-Z][a-zA-Z0-9\-\.]*$' -and $hostname -notlike '*..*') {
        return $true
    } else {
        Write-Host "Please enter a valid hostname starting with a letter." -ForegroundColor Red
        return $false
    }
}

# Function to get user input with validation
function Get-ValidatedInput($prompt, $validationFunction) {
    do {
        $input = Read-Host $prompt
        $input = $input.ToLower()  # Ensure input is processed in lowercase
        if ($validationFunction -is [scriptblock]) {
            if (& $validationFunction $input) {
                return $input
            }
        } elseif (Invoke-Expression "$validationFunction '$input'") {
            return $input
        }
        Write-Host "Invalid input. Please try again." -ForegroundColor Red
    } while ($true)
}

# Function to log messages with dynamic path and file name configuration
function Log-Message {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$Level = "INFO"
    )
    # To change the log directory, modify the `$logPath` assignment below
    $rootPath = [System.IO.Path]::GetPathRoot((Get-Process -id $pid).Path)
    $logPath = Join-Path -Path $rootPath -ChildPath "BackupSimulatorLog.txt"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp [$Level] - $Message"
    Add-Content -Path $logPath -Value $logEntry
}

# Function to prompt for a password and confirm it matches
function Get-ConfirmedPassword {
    do {
        # Prompt for the password
        $password = Read-Host "Enter your password for vSphere (input will be hidden)" -AsSecureString
        # Prompt for the password confirmation
        $confirmPassword = Read-Host "Confirm your password" -AsSecureString

        # Convert SecureString to plain text to compare
        $passwordText = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
        $confirmPasswordText = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmPassword))

        if ($passwordText -eq $confirmPasswordText) {
            Write-Host "Password confirmed." -ForegroundColor Green
            return $password  # Return the confirmed password as a SecureString
        } else {
            Write-Host "Passwords do not match. Please try again." -ForegroundColor Red
            # Clear the plaintext password variables for security after each mismatch
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmPassword))
        }
    } while ($true)  # This loop continues until the correct password is confirmed
}

# Function to handle the backup process
function Invoke-BackupProcess {
    $system = Get-ValidatedInput "Enter the system name" ${function:IsValidHostname}
    $type = Get-ValidatedInput "Enter the type of backup (e.g., full, incremental)" ${function:IsValidHostname}
    $vSphereIP = Get-ValidatedInput "Enter the IP address for vSphere" ${function:IsValidIpAddress}
    $username = Read-Host "Enter your username for vSphere"
    $password = Get-ConfirmedPassword  

    $backupName = "$system-$type-$todayDate"

    Write-Host "Starting backup for $backupName on vSphere system at $vSphereIP..."
    Start-Sleep -Seconds 5  # Simulate backup process
    Write-Host "Backup completed successfully."

    $exitScript = Read-Host "Backup is done, do you want to exit? (yes/no)"
    if ($exitScript -eq "yes") {
        Write-Host "Exiting the script."
        exit
    }
}

# Main script execution loop
while ($true) {
    Invoke-BackupProcess
}
