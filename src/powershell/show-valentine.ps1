##############################################################################
# WTFPL 2.0 / Copyright (C) 2024 haloperidozz (TikTok: @haloperidozz)
##############################################################################

# Environment variables:

# TITLE                     ["Will you be my valentine?"]
# AGREE_BUTTON_TEXT         ["Yes"]
# AGREE_DIALOG_TEXT         ["I LOVE YOU!!!"]
# AGREE_DIALOG_TITLE        ["<3"]
# PHRASES                   ["No;Are you sure?;:("]

##############################################################################

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

##############################################################################
# Font
##############################################################################

$font = New-Object System.Drawing.Font("Arial", 24)

##############################################################################
# Screen
##############################################################################

$screen = [System.Windows.Forms.Screen]::PrimaryScreen
$screenBounds = $screen.WorkingArea

##############################################################################
# Form
##############################################################################

$form = New-Object System.Windows.Forms.Form
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$form.WindowState = "Maximized"
$form.TopMost = $true
$form.BackColor = [System.Drawing.Color]::Magenta
$form.TransparencyKey = [System.Drawing.Color]::Magenta

##############################################################################
# Label
##############################################################################

$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Width = $screenBounds.Width
$titleLabel.Height = [int]($screenBounds.Height / 2)
$titleLabel.Text = $env:TITLE
$titleLabel.Font = $font
$titleLabel.TextAlign = "MiddleCenter"
$titleLabel.BackColor = [System.Drawing.Color]::Black
$titleLabel.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($titleLabel)
$titleLabel.SendToBack()

##############################################################################
# Agree Button
##############################################################################

$agreeButton = New-Object System.Windows.Forms.Button
$agreeButton.Width = [int]($screenBounds.Width / 2 - 100)
$agreeButton.Height = 50
$agreeButton.Location = New-Object System.Drawing.Point(
    50, 
    [int]($screenBounds.Height - 150)
)
$agreeButton.BackColor = [System.Drawing.Color]::Green
$agreeButton.ForeColor = [System.Drawing.Color]::White
$agreeButton.Text = $env:AGREE_BUTTON_TEXT
$agreeButton.Font = $font
$agreeButton.Add_Click({
    [System.Windows.Forms.MessageBox]::Show(
        $env:AGREE_DIALOG_TEXT,
        $env:AGREE_DIALOG_TITLE,
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
    [System.Windows.Forms.Application]::Exit()
})
$form.Controls.Add($agreeButton)
$agreeButton.BringToFront()

##############################################################################
# Deny Button
##############################################################################

$denyButtonPhrases = $env:PHRASES -split ";"

$denyButton = New-Object System.Windows.Forms.Button
$denyButton.Width = [int]($screenBounds.Width / 2 - 100)
$denyButton.Height = 50
$denyButton.Location = New-Object System.Drawing.Point(
    [int]($screenBounds.Width - $denyButton.Width - 50), 
    [int]($screenBounds.Height - 150)
)
$denyButton.BackColor = [System.Drawing.Color]::Red
$denyButton.ForeColor = [System.Drawing.Color]::White
$denyButton.Text = $denyButtonPhrases[0]
$denyButton.Font = $font
$denyButton.Add_Click({
    $agreeButton.Location -= New-Object System.Drawing.Point(5, 30)
    $agreeButton.Width += 35
    $agreeButton.Height += 35
    $denyButton.Text = $denyButtonPhrases | Get-Random
})
$form.Controls.Add($denyButton)
$denyButton.SendToBack()

##############################################################################
# Run
##############################################################################

[System.Windows.Forms.Application]::Run($form)
