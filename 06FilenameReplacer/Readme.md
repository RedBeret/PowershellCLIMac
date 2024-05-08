# PowerShell PDF Filename Normalizer

This PowerShell script is designed to rename PDF files in its directory by adding a "EDITED_" prefix and removing any "_edited" suffixes, ensuring filename consistency. It checks for existing target filenames to avoid conflicts and provides an option to delete the script post-operation for security.

## Features

- **Normalization**: Adds a "EDITED_" prefix and removes "_edited" suffixes from PDF filenames.
- **Conflict Avoidance**: Skips renaming if the target filename already exists to prevent overwriting.
- **Script Deletion Option**: Offers to delete itself after successful operation to maintain a clean environment.

## Getting Started

### Prerequisites

Ensure that PowerShell is installed on your system to run the script. This script is intended for use on Windows 10 and above.

### Installation

1. Clone the repository to your local machine using Git:
   ```bash
   git clone https://github.com/RedBeret/PowershellCLIMac.git
   ```
2. Navigate to the directory where `PDFEditPrefixTool.ps1` is located:
   ```bash
   cd PowershellCLIMac
   ```

### Usage

To execute the PDF filename normalizer, follow these steps:

1. Move the `PDFEditPrefixTool.ps1` script into the directory containing your PDF files.
2. Run the script by entering the following command in PowerShell:
   ```powershell
   .\PDFEditPrefixTool.ps1
   ```
3. Confirm the prompt to proceed with renaming the PDF files.

The script will then automatically rename all PDF files in the directory, skipping any files where the new name would conflict with existing files.

## Versioning

- **Version 1.0** - Initial release

## Authors

- **RedBeret** - Initial work - [RedBeret](https://github.com/RedBeret)

## Acknowledgments

- Thanks to all who provided feedback and suggestions.
- Special thanks to the PowerShell community for testing and support.
