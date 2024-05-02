Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Backups 2.0'
$form.Size = New-Object System.Drawing.Size(500, 600)
$form.StartPosition = 'CenterScreen'

# Common Font for Readability
$commonFont = New-Object System.Drawing.Font("Arial", 16)

# Label for High Level Name
$labelHull = New-Object System.Windows.Forms.Label
$labelHull.Text = "High Level Name (max 6 chars)"
$labelHull.Location = New-Object System.Drawing.Point(10, 20)
$labelHull.Size = New-Object System.Drawing.Size(460, 30)
$labelHull.Font = $commonFont
$form.Controls.Add($labelHull)

# TextBox for High Level Name
$textBoxHull = New-Object System.Windows.Forms.TextBox
$textBoxHull.Location = New-Object System.Drawing.Point(10, 50)
$textBoxHull.Size = New-Object System.Drawing.Size(460, 30)
$textBoxHull.Font = $commonFont
$textBoxHull.MaxLength = 6
$form.Controls.Add($textBoxHull)

# Label for Low Level Name
$labelShipName = New-Object System.Windows.Forms.Label
$labelShipName.Text = "Low Level Name"
$labelShipName.Location = New-Object System.Drawing.Point(10, 90)
$labelShipName.Size = New-Object System.Drawing.Size(460, 30)
$labelShipName.Font = $commonFont
$form.Controls.Add($labelShipName)

# TextBox for Low Level Name
$textBoxShipName = New-Object System.Windows.Forms.TextBox
$textBoxShipName.Location = New-Object System.Drawing.Point(10, 120)
$textBoxShipName.Size = New-Object System.Drawing.Size(460, 30)
$textBoxShipName.Font = $commonFont
$form.Controls.Add($textBoxShipName)

# Label for Type
$labelType = New-Object System.Windows.Forms.Label
$labelType.Text = "Type (A, B, C)"
$labelType.Location = New-Object System.Drawing.Point(10, 160)
$labelType.Size = New-Object System.Drawing.Size(460, 30)
$labelType.Font = $commonFont
$form.Controls.Add($labelType)

# ComboBox for Type
$comboBoxType = New-Object System.Windows.Forms.ComboBox
$comboBoxType.Location = New-Object System.Drawing.Point(10, 190)
$comboBoxType.Size = New-Object System.Drawing.Size(460, 30)
$comboBoxType.Font = $commonFont
$comboBoxType.DropDownStyle = 'DropDownList'
$comboBoxType.Items.AddRange(@('A', 'B', 'C'))
$form.Controls.Add($comboBoxType)

# Panel for Progress Status
$panel = New-Object System.Windows.Forms.Panel
$panel.Location = New-Object System.Drawing.Point(10, 350)
$panel.Size = New-Object System.Drawing.Size(460, 140)
$form.Controls.Add($panel)

# Status Label inside Panel
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Ready to start backup..."
$statusLabel.ForeColor = 'Red'
$statusLabel.Font = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
$statusLabel.Location = New-Object System.Drawing.Point(10, 10)
$statusLabel.Size = New-Object System.Drawing.Size(460, 40)
$statusLabel.TextAlign = 'MiddleCenter'
$panel.Controls.Add($statusLabel)

# Current VM Label
$currentVMLabel = New-Object System.Windows.Forms.Label
$currentVMLabel.Font = $commonFont
$currentVMLabel.Location = New-Object System.Drawing.Point(10, 50)
$currentVMLabel.Size = New-Object System.Drawing.Size(460, 30)
$currentVMLabel.TextAlign = 'MiddleCenter'
$panel.Controls.Add($currentVMLabel)

# ProgressBar inside Panel
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(10, 80)
$progressBar.Size = New-Object System.Drawing.Size(460, 30)
# $progressBar.Style = 'Continuous'
$progressBar.ForeColor = [System.Drawing.Color]::Green  
$panel.Controls.Add($progressBar)

# Timer for simulating Backup process
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000  
$timer.Tag = 0  
$totalVMs = 10  

$timer.Add_Tick({
    $timer.Tag++
    $percentageCompleted = ($timer.Tag * 100) / $totalVMs
    $currentVMLabel.Text = "Backing up VM $($timer.Tag) of $totalVMs (Total $percentageCompleted%)"
    $progressBar.Value = $percentageCompleted

    if ($timer.Tag -eq $totalVMs) {
        $timer.Stop()
        $statusLabel.Text = "Backup Complete"
        $statusLabel.ForeColor = [System.Drawing.Color]::Green
        $currentVMLabel.ForeColor = [System.Drawing.Color]::Green
        $textBoxHull.Enabled = $true
        $textBoxShipName.Enabled = $true
        $comboBoxType.Enabled = $true
        [System.Windows.Forms.MessageBox]::Show('Backup completed successfully.')
        $progressBar.Value = 0
        $timer.Tag = 0
        $btnBackup.Enabled = $true  
        $btnRestore.Enabled = $true 
    }
})

# Backup Button
$btnBackup = New-Object System.Windows.Forms.Button
$btnBackup.Location = New-Object System.Drawing.Point(10, 230)
$btnBackup.Size = New-Object System.Drawing.Size(150, 60)
$btnBackup.BackColor = [System.Drawing.Color]::LightGray
$btnBackup.ForeColor = [System.Drawing.Color]::Black
$btnBackup.Text = 'Perform Backup'
$btnBackup.Font = $commonFont
$btnBackup.Add_Click({
    $panel.Visible = $true
    $progressBar.Value = 0
    $counter = 0
    $statusLabel.Text = "Backup in Progress - Please do not touch!"
    $textBoxHull.Enabled = $false
    $textBoxShipName.Enabled = $false
    $comboBoxType.Enabled = $false
    $timer.Start()
})
$form.Controls.Add($btnBackup)

# Backup Button Click Event
$btnBackup.Add_Click({
    $panel.Visible = $true
    $progressBar.Value = 0
    $timer.Tag = 0
    $statusLabel.Text = "Backup in Progress - Please do not touch!"
    $textBoxHull.Enabled = $false
    $textBoxShipName.Enabled = $false
    $comboBoxType.Enabled = $false
    $btnBackup.Enabled = $false 
    $btnRestore.Enabled = $false 
    $timer.Start()
})


# Restore Button
$btnRestore = New-Object System.Windows.Forms.Button
$btnRestore.Location = New-Object System.Drawing.Point(170, 230)
$btnRestore.Size = New-Object System.Drawing.Size(150, 60)
$btnRestore.BackColor = [System.Drawing.Color]::LightGray
$btnRestore.ForeColor = [System.Drawing.Color]::Black
$btnRestore.Text = 'Restore VM'
$btnRestore.Font = $commonFont
$btnRestore.Add_Click({
    # Restore VM logic here
    [System.Windows.Forms.MessageBox]::Show('VM restore development in progress. Please check with your leads for alternate.')
})
$form.Controls.Add($btnRestore)

# Restore Button Click Event
$btnRestore.Add_Click({
    [System.Windows.Forms.MessageBox]::Show('VM restore development in progress. Please check with your leads for alternate.')
})

# Exit Button
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Location = New-Object System.Drawing.Point(330, 230)
$btnExit.Size = New-Object System.Drawing.Size(150, 60)
$btnExit.BackColor = [System.Drawing.Color]::LightGray
$btnExit.ForeColor = [System.Drawing.Color]::Black
$btnExit.Text = 'Exit'
$btnExit.Font = $commonFont
$btnExit.Add_Click({ $form.Close() })
$form.Controls.Add($btnExit)

# Exit Button Click Event
$btnExit.Add_Click({
    $confirmation = [System.Windows.Forms.MessageBox]::Show('Are you sure you want to exit?', 'Exit Confirmation', [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($confirmation -eq 'Yes') {
        $form.Close()
    }
})

# Initially, hide the panel until the backup starts
$panel.Visible = $false

$form.ShowDialog()
