# PowerShell JSON Log Manager

This PowerShell script manages a JSON log file that records system and custom variable data. It is designed to minimize redundant writes by checking if the log was created or updated within the last week before making new entries. The script also allows users to review and then delete the log file to maintain data hygiene.

## Features

- **Efficient Logging**: Only updates the JSON log if it hasn't been updated in the last 7 days to reduce unnecessary disk writes.
- **System and Custom Data Logging**: Logs data like system name, OS version, and any custom variables passed to it.
- **User Review and Clean-up**: Prompts users to review the log contents and confirms before deleting the log file, ensuring that data handling is both transparent and secure.

## Getting Started

### Prerequisites

Make sure PowerShell is installed on your system to run the script. This script is compatible with Windows 10 and above.

### Installation

1. Clone the repository to your local machine using Git:
   ```bash
   git clone https://github.com/RedBeret/PowershellCLIMac.git
   ```
2. Navigate to the script directory where `JsonVariableWeeklyLogger.ps1` is located:
   ```bash
   cd PowershellCLIMac
   ```

### Usage

To run the JSON log manager, execute the following command in PowerShell:

```powershell
.\ScriptName.ps1
```

Follow the on-screen instructions to review the log file contents and decide when to delete it, ensuring no unnecessary data storage.

## Versioning

- **Version 1.0** - Initial release

## Authors

- **RedBeret** - Initial work - [RedBeret](https://github.com/RedBeret)

## Acknowledgments

- Thanks to all whose ideas and code inspired this project.
- Special thanks to the PowerShell community for testing and feedback.
