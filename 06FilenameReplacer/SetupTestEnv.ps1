# Define the path for the test directory on the desktop
$testDirectory = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "test")

# Create the test directory if it does not exist
if (-not (Test-Path -Path $testDirectory)) {
    New-Item -Path $testDirectory -ItemType Directory
}

# Define an array of test filenames
$testFilenames = @(
    "file2.pdf",
    "file1_edited.pdf",
    "file3_EDITED.pdf",
    "file4_edited_.pdf",
    "file5_eDitED.pdf",
    "EDITED_file.pdf",
"test.txt"
)

# Create each test PDF file in the test directory
foreach ($filename in $testFilenames) {
    $filePath = [System.IO.Path]::Combine($testDirectory, $filename)
    
    # Check if file already exists to avoid overwriting
    if (-not (Test-Path -Path $filePath)) {
        # Since actual PDF content isn't needed, just create an empty file with .pdf extension
        New-Item -Path $filePath -ItemType File
    }
}

Write-Host "Test environment setup complete. Check your desktop 'test' folder."
