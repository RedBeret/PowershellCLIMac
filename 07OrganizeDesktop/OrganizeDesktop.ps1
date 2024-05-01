<#
.SYNOPSIS
Sets up a test environment and organizes files into folders based on their extension types within the 'DESKTOPTEST' folder created on the desktop.

.DESCRIPTION
This script creates a 'DESKTOPTEST' directory on the desktop, populates it with various types of test files, opens the directory for inspection, and then organizes the files into folders based on their extensions.

.NOTES
Version:        1.0
Author:         RedBeret
GitHub:         https://github.com/RedBeret
Creation Date:  30APR2024
Last Edit:      30APR2024
Execution Policy: The script sets the execution policy to 'RemoteSigned' for the current user, allowing scripts to be run with a basic security check.

.EXAMPLE
Navigate to the script's directory and run:
.\OrganizeDesktop.ps1
#>

# Check and set the execution policy to ensure the script can run without security interruptions
$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($currentPolicy -ne 'RemoteSigned') {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Write-Host "Execution policy set to RemoteSigned."
}

# Create the 'DESKTOPTEST' test directory on the desktop
$testDirectory = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "DESKTOPTEST")
if (-not (Test-Path -Path $testDirectory)) {
    New-Item -Path $testDirectory -ItemType Directory | Out-Null
    Write-Host "Created 'DESKTOPTEST' directory."
} else {
    Write-Host "'DESKTOPTEST' directory already exists."
}

# Define a more complex array of test filenames including different formats and naming conventions
$testFilenames = @(
    "report_final_review.docx",
    "budget_2024.xlsx",
    "presentation_2024.pptx",
    "archive.zip",
    "image_edited.jpeg",
    "notes_edited_04_30.txt",
    "config_backup.xml",
    "script_test.ps1"
)

# Create test files in the 'DESKTOPTEST' directory, adding various file types
foreach ($filename in $testFilenames) {
    $filePath = [System.IO.Path]::Combine($testDirectory, $filename)
    if (-not (Test-Path -Path $filePath)) {
        New-Item -Path $filePath -ItemType File | Out-Null
        Write-Host "Created file: $filePath"
    } else {
        Write-Host "File already exists: $filePath"
    }
}

# Open the 'DESKTOPTEST' folder to view test files, allowing user to verify files before organizing
Start-Process "explorer.exe" $testDirectory
Write-Host "Test environment setup complete in 'DESKTOPTEST' folder. Press any key to continue with file organization..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Organize files by their extension, sorting them into appropriate folders
$files = Get-ChildItem -Path $testDirectory -File
foreach ($file in $files) {
    $extension = $file.Extension.TrimStart(".")
    $folderName = if ($extension) { $extension } else { "Other" }
    $destinationFolder = Join-Path -Path $testDirectory -ChildPath $folderName

    if (-not (Test-Path -Path $destinationFolder)) {
        New-Item -Path $destinationFolder -ItemType Directory | Out-Null
        Write-Host "Created folder for $folderName files."
    }

    $destinationPath = Join-Path -Path $destinationFolder -ChildPath $file.Name
    Move-Item -Path $file.FullName -Destination $destinationPath
    Write-Host "Moved `"$($file.Name)`" to `"$destinationPath`" in $folderName folder."
}

Write-Host "Files have been organized into folders based on their type in the 'DESKTOPTEST' folder."
