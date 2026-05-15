# shot2cli

Paste screenshots into CLI apps (Claude Code, Gemini CLI, Codex, etc.) with a single **Ctrl+V**.

## The Problem

When you take a screenshot on Windows (Win+Shift+S), the image sits on the clipboard as a bitmap. CLI tools running inside terminal apps can't receive bitmaps, they only accept text. So Ctrl+V does nothing, or pastes garbage.

Web apps like Claude.ai or Gemini work fine because the **browser** handles the conversion. Terminals don't.

## How It Works

shot2cli runs quietly in your system tray. When you press **Ctrl+V** in Windows Terminal:

- **Clipboard has an image** -> finds the latest `.png` in your Screenshots folder and types the path directly into the terminal
- **Clipboard has text** -> normal paste, nothing changes

Your clipboard stays untouched. Web app paste still works as before.

## Requirements

- Windows 10/11
- [AutoHotkey v2](https://www.autohotkey.com/) (free)
- Windows Terminal
- Snipping Tool with **Automatically save screenshots** enabled (Settings -> toggle on)

## Install

1. **Install AutoHotkey v2**: [download from autohotkey.com](https://www.autohotkey.com/) or:
   ```powershell
   winget install AutoHotkey.AutoHotkey
   ```

2. **Run the installer** (right-click -> Run with PowerShell):
   ```powershell
   .\install.ps1
   ```

That's it. shot2cli starts automatically on login.

## Uninstall

```powershell
.\uninstall.ps1
```

## Usage

1. Take a screenshot: **Win+Shift+S** (make sure Snipping Tool auto-save is on)
2. Click into your terminal prompt
3. Press **Ctrl+V** -> the path is typed in
4. Send your message

## License

MIT
