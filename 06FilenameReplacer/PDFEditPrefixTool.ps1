<#
.SYNOPSIS
Renames PDF files by adding a prefix "EDITED_" and removing any "_edited" suffixes.

.DESCRIPTION
This script is designed to normalize PDF filenames within its current directory
by ensuring they all begin with "EDITED_" and do not end with variations of "_edited".
It skips renaming if the target filename already exists to avoid conflicts.

.NOTES
Version:        1.0
Author:         RedBeret
GitHub:         https://github.com/RedBeret
Creation Date:  29APR2024
Last Edit:      29APR2024

.EXAMPLE
To execute this script, navigate to the script's directory and run:
.\PDFEditPrefixTool.ps1

#>

# Define the path for the directory where the script is located
$scriptDirectory = $PSScriptRoot

# This function will update the filename
function Update-FileName {
    param([string]$originalName)
    
    # Remove any ".pdf" extension for easy manipulation
    $nameWithoutExtension = [IO.Path]::GetFileNameWithoutExtension($originalName)
    
    # Normalize case for checking 'edited' suffix and 'EDITED_' prefix
    $normalized = $nameWithoutExtension.ToLower()
    
    # Remove any 'edited_' prefix and '_edited' or '_edited_' suffixes
    $newName = $normalized -replace '^edited_', '' -replace '_edited$', '' -replace '_edited_$', ''
    
    # Add "EDITED_" prefix
    $newName = "EDITED_" + $newName
    
    # Return the new name with the .pdf extension, only if it has changed
    if ($newName -ne $normalized) {
        return $newName + [IO.Path]::GetExtension($originalName)
    } else {
        return $originalName
    }
}

# Get all .pdf files in the script's directory
$pdfFiles = Get-ChildItem -Path $scriptDirectory -Filter *.pdf -File

# Check if PDF files are found
if ($pdfFiles.Count -eq 0) {
    Write-Host "No PDF files to rename found. Please move this script to the folder where the renaming files are located."
    exit
}

# Confirm with the user before proceeding
$response = Read-Host "The script will rename files to format 'EDITED_filename.pdf'. Continue? (yes/no)"
if ($response -eq "yes") {
    # Rename operation here...
    foreach ($file in $pdfFiles) {
        $newName = Update-FileName $file.Name
        
        # Only attempt to rename if the new name is different
        if ($newName -ne $file.Name) {
            $newFullPath = Join-Path $scriptDirectory $newName
            
            # Check if the new file name already exists to avoid conflicts
            if (-not (Test-Path -Path $newFullPath)) {
                Rename-Item -Path $file.FullName -NewName $newName
            } else {
                Write-Warning "Skipped renaming because the target name '$newName' already exists."
            }
        }
    }
    Write-Host "File renaming completed. Please review the changes to confirm they are correct."

    # Ask the user to verify the changes
    $confirm = Read-Host "If all files have been renamed correctly, the script will be deleted. Do you want to delete the script? (yes/no)"
    if ($confirm -eq "yes") {
        # Delete this script
        Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force
        Write-Host "The script has been deleted successfully."
    } else {
        Write-Host "The script will not be deleted. Review the files and run the script again if needed."
    }
} elseif ($response -eq "no") {
    Write-Host "Operation aborted by the user."
} else {
    Write-Host "Invalid response. Please run the script again and enter 'yes' or 'no'."
}