# Function Definitions`
function IsValidIpAddress($address) {
    return $address -match '^((25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.){3}(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)$'
}

function IsValidHostname($hostname) {
    return $hostname -match '^[a-zA-Z][a-zA-Z0-9\-\.]*$' -and $hostname -notlike '*..*'
}

function Invoke-PingSimulation {
    $address = Read-Host "Enter the IP address or hostname"
    if (-not $address) {
        Write-Host "No address entered. Please try again." -ForegroundColor Red
        return
    }

    if (-not (IsValidIpAddress $address -or IsValidHostname $address)) {
        return
    }

    Write-Host "Simulating ping to $address..."
    Start-Sleep -Seconds 2
    1..4 | ForEach-Object {
        Write-Host "Reply from ${address}: bytes=32 time=$(Get-Random -Minimum 20 -Maximum 100)ms TTL=128"
    }
    Write-Host "Press any key to continue..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Invoke-TracerouteSimulation {
    $address = Read-Host "Enter the IP address or hostname"
    if (-not $address) {
        Write-Host "No address entered. Please try again."
        return
    }

    if (-not (IsValidIpAddress $address -or IsValidHostname $address)) {
        return
    }

    Write-Host "Simulating traceroute to $address..."
    Start-Sleep -Seconds 2
    1..5 | ForEach-Object {
        Write-Host "$_    $(Get-Random -Minimum 1 -Maximum 50) ms    $(Get-Random -Minimum 1 -Maximum 50) ms    $(Get-Random -Minimum 1 -Maximum 50) ms  10.0.$_.1"
    }
    Write-Host "Press any key to continue..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Invoke-NetworkConfig {
    Write-Host "Showing simulated network configuration..."
    Start-Sleep -Seconds 1
    Write-Host "Interface: Ethernet"
    Write-Host "IPv4 Address: 192.168.1.$(Get-Random -Minimum 100 -Maximum 200)"
    Write-Host "Subnet Mask: 255.255.255.0"
    Write-Host "Default Gateway: 192.168.1.1"
    Write-Host "Press any key to continue..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Invoke-DNSLookupSimulation {
    $domain = Read-Host "Enter the domain name"
    if (-not $domain) {
        Write-Host "No domain name entered. Please try again." -ForegroundColor Red
        return
    }
    if (-not (IsValidHostname $domain)) {
        return
    }
    
    Write-Host "Simulating DNS lookup for $domain..."
    Start-Sleep -Seconds 2
    Write-Host "Name:    $domain"
    Write-Host "Address:  $(Get-Random -Minimum 100 -Maximum 200).$(Get-Random -Minimum 0 -Maximum 255).$(Get-Random -Minimum 0 -Maximum 255).$(Get-Random -Minimum 0 -Maximum 255)"
    Write-Host "Press any key to continue..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Invoke-PortScan {
    $targetIP = Read-Host "Enter the target IP address for port scanning"
    if (-not (IsValidIpAddress $targetIP)) {
        Write-Host "Invalid IP address entered. Please enter a valid IP address." -ForegroundColor Red
        return
    }

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
    Write-Host "Press any key to continue..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Main Menu Loop

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
