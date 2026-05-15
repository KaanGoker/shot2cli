# shot2cli uninstaller

Get-Process AutoHotkey64 -ErrorAction SilentlyContinue | Stop-Process -Force

$startup = [Environment]::GetFolderPath('Startup')
$lnk = Join-Path $startup "shot2cli.lnk"
if (Test-Path $lnk) { Remove-Item $lnk -Force; Write-Host "Removed: $lnk" }

$script = Join-Path $env:USERPROFILE "shot2cli.ahk"
if (Test-Path $script) { Remove-Item $script -Force; Write-Host "Removed: $script" }

Write-Host "shot2cli uninstalled."
