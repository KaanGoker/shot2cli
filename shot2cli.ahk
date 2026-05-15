#Requires AutoHotkey v2.0
#SingleInstance Force

TraySetIcon("shell32.dll", 261)
A_IconTip := "shot2cli - screenshot to CLI apps"
try A_TrayMenu.Delete("Help")
try A_TrayMenu.Delete("&Help")

ScreenshotDir := EnvGet("USERPROFILE") . "\Pictures\Screenshots"

#HotIf WinActive("ahk_exe WindowsTerminal.exe")
$^v:: {
    global ScreenshotDir
    if !DllCall("IsClipboardFormatAvailable", "UInt", 8) {
        SendInput("^v")
        return
    }
    latestFile := ""
    latestTime := 0
    Loop Files ScreenshotDir "\*.png" {
        if (A_LoopFileTimeModified > latestTime) {
            latestTime := A_LoopFileTimeModified
            latestFile := A_LoopFileFullPath
        }
    }
    if (latestFile = "") {
        SendInput("^v")
        return
    }
    drive := StrLower(SubStr(latestFile, 1, 1))
    rest := SubStr(latestFile, 3)
    wslPath := "/mnt/" . drive . StrReplace(rest, "\", "/")
    ESC := Chr(27)
    SendText(ESC . "[200~'" . wslPath . "'" . ESC . "[201~")
}
#HotIf
