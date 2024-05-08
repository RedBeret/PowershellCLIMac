# PowerShell Variable Logger

This PowerShell script is designed to log system information and user-defined messages to a text file, followed by a prompt for user verification before automatically deleting the file. It's an excellent tool for understanding basic file operations and system interaction using PowerShell.

## Features

- **System Information Logging**: Logs the computer's name and operating system version.
- **Custom Message Logging**: Allows users to define custom messages that get logged into the file.
- **User Interaction**: After logging, the script prompts the user to check the log file before it is automatically deleted for clean operation.

## Getting Started

### Prerequisites

Ensure that PowerShell is installed on your system to run the scripts. These scripts are tested on Windows 10 and above.

### Installation

1. Clone the repository to your local machine using Git:
   ```bash
   git clone https://github.com/RedBeret/PowershellCLIMac.git
   ```
2. Navigate to the script directory where `VariableLogger.ps1` is located:
   ```bash
   cd PowershellCLIMac
   ```

### Usage

To run the variable logger, execute the following command in PowerShell:

```powershell
.\VariableLogger.ps1
```

After execution, verify the contents of the log file as prompted, after which the file will be automatically deleted.

## Versioning

- **Version 1.0** - Initial release

## Authors

- **RedBeret** - Initial work - [RedBeret](https://github.com/RedBeret)

## Acknowledgments

- Hat tip to anyone whose code was used as inspiration.
- Special thanks to the online community for testing and feedback.
