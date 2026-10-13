$env:TERM = 'xterm-256color'

# ListView needs PSReadLine 2.2+ (Windows PowerShell 5.1 ships 2.0)
if ((Get-Module PSReadLine).Version -ge [version]'2.2') {
  Set-PSReadLineOption -PredictionViewStyle ListView
}

if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}
