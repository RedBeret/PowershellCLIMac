# PowerShell ESXi Backup Simulator

This PowerShell script is designed to simulate the backup process for systems to an ESXi server. It offers a comprehensive simulation, including input validation, secure password handling, activity logging, and more, ideal for educational and testing purposes.

## Features

- **Input Validation**: Validates IP addresses and hostnames to ensure correct data is entered.
- **Secure Password Handling**: Securely handles password input and confirmation for ESXi server access.
- **Logging**: Logs all activities during the simulation to a file, aiding in debugging and learning.
- **Interactive**: Allows users to interactively enter details, simulate backups, and decide to repeat or exit the process.

## Getting Started

### Prerequisites

Ensure that PowerShell is installed on your system to run the scripts. These scripts are tested on Windows 10 and above.

### Installation

1. Clone the repository to your local machine using Git:
   ```bash
   git clone https://github.com/RedBeret/PowershellCLIMac.git
   ```
2. Navigate to the script directory where `BackupSimulator.ps1` is located:
   ```bash
   cd PowershellCLIMac
   ```

### Usage

To run the backup simulator, execute the following command in PowerShell:

```powershell
.\02BackupSimulator.ps1
```

Follow the on-screen prompts to input system details, backup type, ESXi credentials, and manage the backup simulation.

## Versioning

- **Version 1.0** - Initial release

## Authors

- **RedBeret** - Initial work - [RedBeret](https://github.com/RedBeret)

## Acknowledgments

- Hat tip to anyone whose code was used as inspiration.
- Special thanks to the online community for testing and feedback.
