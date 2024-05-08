# PowerShell Desktop Test Environment Organizer

This PowerShell script creates a 'DESKTOPTEST' directory on the desktop and organizes various test files into folders based on their extensions. It's designed to facilitate a quick setup of a controlled environment for testing or demonstration purposes.

## Features

- **Environment Setup**: Automatically sets the PowerShell execution policy to 'RemoteSigned' to allow script execution with basic security checks.
- **Directory Creation**: Generates a 'DESKTOPTEST' directory directly on the desktop.
- **File Organization**: Organizes files into folders according to their file extension, aiding in easy access and management.

## Getting Started

### Prerequisites

Ensure that PowerShell is installed on your system to run the script. This script is compatible with Windows environments where PowerShell can alter execution policies.

### Installation

1. Clone the repository to your local machine using Git:
   ```bash
   git clone https://github.com/RedBeret/PowershellCLIMac.git
   ```
2. Navigate to the directory where `OrganizeDesktop.ps1` is located:
   ```bash
   cd PowershellCLIMac
   ```

### Usage

To set up and organize the test environment, follow these steps:

1. Open PowerShell as Administrator. This is necessary for setting the execution policy if it is not already set.
2. Execute the script by entering the following command:
   ```powershell
   .\OrganizeDesktop.ps1
   ```
3. The script will create the 'DESKTOPTEST' directory, populate it with various test files, and open it for inspection.
4. After verifying the files, press any key to continue, and the script will organize the files into extension-specific folders.

## Versioning

- **Version 1.0** - Initial release

## Authors

- **RedBeret** - Initial work - [RedBeret](https://github.com/RedBeret)

## Acknowledgments

- Thanks to all who provided insights and feedback on the script development.
- Special thanks to the PowerShell community for their support and contributions.
