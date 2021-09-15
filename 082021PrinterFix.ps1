REG ADD "HKLM\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0
REG ADD "HKLM\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v UpdatePromptSettings /t REG_DWORD /d 0
REG ADD "HKLM\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v NoWarningNoElevationOnInstall /t REG_DWORD /d 0
             
             Add-Type -AssemblyName System.Windows.Forms
             Add-Type -AssemblyName System.Drawing

             $form = New-Object System.Windows.Forms.Form
             $form.Text = 'Add a Printer'
             $form.Size = New-Object System.Drawing.Size(300,200)
             $form.StartPosition = 'CenterScreen'

             $okButton = New-Object System.Windows.Forms.Button
             $okButton.Location = New-Object System.Drawing.Point(75,120)
             $okButton.Size = New-Object System.Drawing.Size(75,23)
             $okButton.Text = 'OK'
             $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
             $form.AcceptButton = $okButton
             $form.Controls.Add($okButton)
 
             $label = New-Object System.Windows.Forms.Label
             $label.Location = New-Object System.Drawing.Point(10,20)
             $label.Size = New-Object System.Drawing.Size(280,20)
             $label.Text = 'Please add desired printers. Hit OK when done.'
             $form.Controls.Add($label)

            $form.Topmost = $true

             $result = $form.ShowDialog()

         
            Remove-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Name 'RestrictDriverInstallationToAdministrators' 
            Remove-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Name 'UpdatePromptSettings' 
            Remove-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Name 'NoWarningNoElevationOnInstall'  
             
      