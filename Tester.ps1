# Requires -Modules Pester
# Load the script that contains the functions to be tested
. '.\BackupSimulator.ps1'

Describe "IsValidIpAddress Tests" {
    It "Validates correct IP address" {
        IsValidIpAddress "192.168.1.1" | Should -Be $true
    }

    It "Rejects incorrect IP address" {
        IsValidIpAddress "999.999.999.999" | Should -Be $false
    }
}

Describe "IsValidHostname Tests" {
    It "Validates correct hostname" {
        IsValidHostname "example.com" | Should -Be $true
    }

    It "Rejects incorrect hostname" {
        IsValidHostname "-example.com" | Should -Be $false
    }

    It "Rejects hostname with double dots" {
        IsValidHostname "example..com" | Should -Be $false
    }
}

Describe "Log-Message Tests" {
    BeforeAll {
        Mock Add-Content
    }

    It "Logs message to the correct file with correct format" {
        Log-Message -Message "Test log entry" -Level "INFO"
        Assert-MockCalled Add-Content -Exactly 1 -Scope It {
            $Args[0] -Match "BackupSimulatorLog.txt" -and
            $Args[1] -Match "^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} \[INFO\] - Test log entry$"
        }
    }
}

Describe "Get-ConfirmedPassword Tests" {
    It "Returns the password if confirmed correctly" {
        Mock Read-Host { "password123" } -ParameterFilter {$AsSecureString -eq $true}
        Mock [Runtime.InteropServices.Marshal]::SecureStringToBSTR { }
        Mock [Runtime.InteropServices.Marshal]::PtrToStringAuto { "password123" }
        $result = Get-ConfirmedPassword
        $result | Should -BeOfType [System.Security.SecureString]
    }

    It "Prompts again if passwords do not match" {
        Mock Read-Host { "password123", "wrongpassword" } -ParameterFilter {$AsSecureString -eq $true}
        Mock [Runtime.InteropServices.Marshal]::SecureStringToBSTR { }
        Mock [Runtime.InteropServices.Marshal]::PtrToStringAuto { "password123", "wrongpassword" }
        $result = Get-ConfirmedPassword
        Assert-MockCalled Read-Host -Times 3 -Scope It
    }
}

# Execute the tests
Invoke-Pester
