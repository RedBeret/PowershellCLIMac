<#
.SYNOPSIS
Simulates various network operations like ping, traceroute, DNS lookup, and port scanning.

.DESCRIPTION
This PowerShell script provides a CLI-based network simulation for educational purposes, allowing users
to perform simulated ping, traceroute, DNS lookup, and port scanning operations to understand basic
network functionalities.

.NOTES
Version:        1.0
Author:         RedBeret
GitHub:         https://github.com/RedBeret
Creation Date:  21APR2024
Last Edit:      29APR2024

.EXAMPLE
.\01NetworkSimulator.ps1
Run the script to interactively simulate network operations.

#>

# Function to validate if the provided string is a valid IP address
function IsValidIpAddress {
    param ([string]$address)
    if ($address -match '^((25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.){3}(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)$') {
        return $true
    } else {
        Write-Host "Invalid IP address. Please ensure it is in the format xxx.xxx.xxx.xxx with each octet between 0 and 255." -ForegroundColor Red
        return $false
    }
}

# Function to validate if the provided string is a valid hostname
function IsValidHostname {
    param ([string]$hostname)
    if ($hostname -match '^[a-zA-Z][a-zA-Z0-9\-\.]*$' -and $hostname -notlike '*..*') {
        return $true
    } else {
        Write-Host "Invalid hostname. Please ensure it starts with a letter and does not contain consecutive dots." -ForegroundColor Red
        return $false
    }
}

# Simulates a ping operation to the provided IP address or hostname
function Invoke-PingSimulation {
    $address = Get-ValidatedInput "Enter the IP address or hostname" ${function:IsValidIpAddress -or ${function:IsValidHostname}}
    Write-Host "Simulating ping to $address..."
    Start-Sleep -Seconds 2
    1..4 | ForEach-Object {
        Write-Host "Reply from ${address}: bytes=32 time=$(Get-Random -Minimum 20 -Maximum 100)ms TTL=128"
    }
    Write-Host "Press any key to continue..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Simulates a traceroute to the provided IP address or hostname
function Invoke-TracerouteSimulation {
    $address = Get-ValidatedInput "Enter the IP address or hostname" ${function:IsValidIpAddress -or ${function:IsValidHostname}}
    Write-Host "Simulating traceroute to $address..."
    Start-Sleep -Seconds 2
    1..5 | ForEach-Object {
        Write-Host "$_    $(Get-Random -Minimum 1 -Maximum 50) ms    $(Get-Random -Minimum 1 -Maximum 50) ms    $(Get-Random -Minimum 1 -Maximum 50) ms  10.0.$_.1"
    }
}

# Shows a simulated network configuration
function Invoke-NetworkConfig {
    Write-Host "Showing simulated network configuration..."
    Start-Sleep -Seconds 1
    Write-Host "Interface: Ethernet"
    Write-Host "IPv4 Address: 192.168.1.$(Get-Random -Minimum 100 -Maximum 200)"
    Write-Host "Subnet Mask: 255.255.255.0"
    Write-Host "Default Gateway: 192.168.1.1"
}

# Simulates a DNS lookup for a domain
function Invoke-DNSLookupSimulation {
    $domain = Get-ValidatedInput "Enter the domain name" ${function:IsValidHostname}
    Write-Host "Simulating DNS lookup for $domain..."
    Start-Sleep -Seconds 2
    Write-Host "Name:    $domain"
    Write-Host "Address:  $(Get-Random -Minimum 100 -Maximum 200).$(Get-Random -Minimum 0 -Maximum 255).$(Get-Random -Minimum 0 -Maximum 255).$(Get-Random -Minimum 0 -Maximum 255)"
}

# Simulates a reverse DNS lookup for an IP address
function Invoke-ReverseDNSLookup {
    $ipAddress = Get-ValidatedInput "Enter the IP address for reverse lookup" ${function:IsValidIpAddress}
    Write-Host "Simulating reverse DNS lookup for $ipAddress..."
    Start-Sleep -Seconds 1
    Write-Host "Hostname: simulated-hostname-for-$ipAddress.com"
}

# Retrieves validated input from the user
function Get-ValidatedInput {
    param (
        [string]$prompt,
        [scriptblock]$validationFunction
    )
    do {
        $input = Read-Host $prompt
        if (& $validationFunction $input) {
            return $input
        }
        Write-Host "Invalid input. Please try again." -ForegroundColor Red
    } while ($true)
}

# Logs messages to a file
function Log-Message {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$Level = "INFO"
    )
    $logPath = "NetworkSimulatorLog.txt"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp [$Level] - $Message"
    Add-Content -Path $logPath -Value $logEntry
}

# Simulates a port scan on an IP address
function Invoke-PortScan {
    $targetIP = Get-ValidatedInput "Enter the target IP address for port scanning" ${function:IsValidIpAddress}
    Write-Host "Simulating a port scan on $targetIP..."
    Start-Sleep -Seconds 1
    $commonPorts = @(22, 80, 443, 3306)
    foreach ($port in $commonPorts) {
        $result = Get-Random -Minimum 0 -Maximum 2
        if ($result -eq 0) {
            Write-Host "Port $port on $targetIP is closed."
        } else {
            Write-Host "Port $port on $targetIP is open."
        }
    }
    Write-Host "Port scan simulation complete."
}

# Main menu display
function Show-Menu {
    Clear-Host
    Write-Host "================ PowerShell Network Simulator ================"
    Write-Host "1: Simulate 'Ping' to an address."
    Write-Host "2: Simulate 'Traceroute' to an address."
    Write-Host "3: Show 'Network Configuration'."
    Write-Host "4: Simulate 'DNS Lookup'."
    Write-Host "5: Simulate Port Scanning."
    Write-Host "Q: Press 'Q' to quit."
}

# Main execution loop
do {
    Show-Menu
    $inputOption = Read-Host "Select an option or press 'Enter' to refresh"
    switch ($inputOption.ToLower()) {
        '1' { Invoke-PingSimulation }
        '2' { Invoke-TracerouteSimulation }
        '3' { Invoke-NetworkConfig }
        '4' { Invoke-DNSLookupSimulation }
        '5' { Invoke-PortScan }
        'q' { return }
        default {
            if ($inputOption -ne '') {
                Write-Host "Invalid option selected. Please try again." -ForegroundColor Red
            }
        }
    }
    if ($inputOption -ne '' -and $inputOption -ne 'q') {
        Write-Host "Press Enter to continue..."
        $null = Read-Host
    }
} while ($inputOption -ne 'q')
