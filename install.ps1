# shot2cli installer
# Run from the folder where shot2cli.ahk is located

$ErrorActionPreference = "Stop"

# Find AutoHotkey v2
$ahkDir = (Get-ItemProperty 'HKCU:\SOFTWARE\AutoHotkey' -ErrorAction SilentlyContinue).InstallDir
if (-not $ahkDir) {
    $ahkDir = (Get-ItemProperty 'HKLM:\SOFTWARE\AutoHotkey' -ErrorAction SilentlyContinue).InstallDir
}
if (-not $ahkDir) {
    Write-Error "AutoHotkey not found. Install it first: https://www.autohotkey.com/"
    exit 1
}
$ahkExe = Join-Path $ahkDir "v2\AutoHotkey64.exe"
if (-not (Test-Path $ahkExe)) {
    Write-Error "AutoHotkey v2 not found at $ahkExe"
    exit 1
}

# Copy script to user profile
$dest = Join-Path $env:USERPROFILE "shot2cli.ahk"
Copy-Item "$PSScriptRoot\shot2cli.ahk" $dest -Force
Write-Host "Copied to: $dest"

# Create startup shortcut
$startup = [Environment]::GetFolderPath('Startup')
$lnk = Join-Path $startup "shot2cli.lnk"
$sh = New-Object -ComObject WScript.Shell
$s = $sh.CreateShortcut($lnk)
$s.TargetPath = $ahkExe
$s.Arguments = '"' + $dest + '"'
$s.WorkingDirectory = $env:USERPROFILE
$s.Save()
Write-Host "Startup shortcut: $lnk"

# Stop any existing instance
Get-Process AutoHotkey64 -ErrorAction SilentlyContinue | Stop-Process -Force

# Launch
Start-Process -FilePath $ahkExe -ArgumentList $dest
Write-Host ""
Write-Host "shot2cli is running. Check your system tray."
Write-Host "Win+Shift+S to screenshot, then Ctrl+V in Windows Terminal to paste the WSL path."
