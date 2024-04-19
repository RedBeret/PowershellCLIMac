function Show-Menu {
    param (
        [string]$Title = 'PowerShell Network Simulator'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Simulate 'Ping' to an address."
    Write-Host "2: Simulate 'Traceroute' to an address."
    Write-Host "3: Show 'Network Configuration'."
    Write-Host "4: Simulate 'DNS Lookup'."
    Write-Host "Q: Press 'Q' to quit."
}

function Simulate-Ping {
    $address = Read-Host "Enter the IP address or hostname"
    if (-not $address) {
        Write-Host "No address entered. Please try again."
        return
    }
    Write-Host "Simulating ping to $address..."
    Start-Sleep -Seconds 2
    1..4 | ForEach-Object {
        Write-Host "Reply from ${address}: bytes=32 time=$(Get-Random -Minimum 20 -Maximum 100)ms TTL=128"
    }
}

function Simulate-Traceroute {
    $address = Read-Host "Enter the IP address or hostname"
    if (-not $address) {
        Write-Host "No address entered. Please try again."
        return
    }
    Write-Host "Simulating traceroute to $address..."
    Start-Sleep -Seconds 2
    1..5 | ForEach-Object {
        Write-Host "$_    $(Get-Random -Minimum 1 -Maximum 50) ms    $(Get-Random -Minimum 1 -Maximum 50) ms    $(Get-Random -Minimum 1 -Maximum 50) ms  10.0.$_.1"
    }
}

function Show-NetworkConfig {
    Write-Host "Interface: Ethernet"
    Write-Host "IPv4 Address: 192.168.1.$(Get-Random -Minimum 100 -Maximum 200)"
    Write-Host "Subnet Mask: 255.255.255.0"
    Write-Host "Default Gateway: 192.168.1.1"
    Start-Sleep -Seconds 1
}

function Simulate-DNSLookup {
    $domain = Read-Host "Enter the domain name"
    if (-not $domain) {
        Write-Host "No domain name entered. Please try again."
        return
    }
    Write-Host "Simulating DNS lookup for $domain..."
    Start-Sleep -Seconds 2
    Write-Host "Name:    $domain"
    Write-Host "Address:  $(Get-Random -Minimum 100 -Maximum 200).$(Get-Random -Minimum 0 -Maximum 255).$(Get-Random -Minimum 0 -Maximum 255).$(Get-Random -Minimum 0 -Maximum 255)"
}

do {
    Show-Menu
    $input = Read-Host "Select an option"
    switch ($input.ToLower()) {
        '1' { Simulate-Ping }
        '2' { Simulate-Traceroute }
        '3' { Show-NetworkConfig }
        '4' { Simulate-DNSLookup }
        'q' { return }
        default { Write-Host "Invalid option selected. Please try again." }
    }
    pause
} while ($input -ne 'q')
