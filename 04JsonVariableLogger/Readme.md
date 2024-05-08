# PowerShell JSON Variable Logger

This PowerShell script efficiently logs both system details and user-defined variables to a JSON file. Designed to aid in learning and debugging, it allows for user interaction to verify the log contents and manage file deletion after review.

## Features

- **JSON Logging**: Logs system information and custom variables in a structured JSON format.
- **Interactive Verification**: Prompts users to verify the log file contents visually before proceeding to delete the file.
- **Automatic Cleanup**: Automatically deletes the log file after verification, keeping the system tidy.

## Getting Started

### Prerequisites

Ensure that PowerShell is installed on your system to run the scripts. These scripts are tested on Windows 10 and above.

### Installation

1. Clone the repository to your local machine using Git:
   ```bash
   git clone https://github.com/RedBeret/PowershellCLIMac.git
   ```
2. Navigate to the script directory where `04JsonVariableLogger.ps1` is located:
   ```bash
   cd PowershellCLIMac
   ```

### Usage

To run the JSON variable logger, execute the following command in PowerShell:

```powershell
.\04JsonVariableLogger.ps1
```

Follow the prompts to verify the contents of the JSON log file before it is automatically deleted. This process helps ensure that all entries are correct and that sensitive data is not left unsecured.

## Versioning

- **Version 1.0** - Initial release

## Authors

- **RedBeret** - Initial work - [RedBeret](https://github.com/RedBeret)

## Acknowledgments

- Hat tip to anyone whose code was used as inspiration.
- Special thanks to the online community for testing and feedback.
