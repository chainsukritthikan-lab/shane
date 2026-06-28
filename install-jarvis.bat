@echo off
color 0B
echo.
echo   ==========================================
echo     J.A.R.V.I.S. - Installation
echo   ==========================================
echo.
echo   This will add Jarvis to Windows startup
echo   so it runs automatically when you log in.
echo.
echo   A small floating "J" icon will appear on
echo   your screen. Click it to open Jarvis.
echo.

set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SOURCE=%~dp0jarvis-widget.vbs"
set "SHORTCUT=%STARTUP%\Jarvis.lnk"

:: Create shortcut in startup folder
powershell -Command "$ws=New-Object -ComObject WScript.Shell; $s=$ws.CreateShortcut('%SHORTCUT%'); $s.TargetPath='wscript.exe'; $s.Arguments='"""%SOURCE%"""'; $s.WorkingDirectory='%~dp0'; $s.Description='J.A.R.V.I.S. Voice Assistant'; $s.Save()"

if exist "%SHORTCUT%" (
    echo   [OK] Jarvis added to Windows startup!
    echo.
    echo   Starting Jarvis now...
    start "" wscript "%SOURCE%"
    echo.
    echo   [OK] Jarvis is running!
    echo.
    echo   ==========================================
    echo   HOW TO USE:
    echo     - Small "J" orb floats on your screen
    echo     - LEFT CLICK the orb = Open Jarvis
    echo     - RIGHT CLICK the orb = Minimize Jarvis
    echo     - DRAG the orb to move it around
    echo     - It starts automatically on login
    echo   ==========================================
) else (
    echo   [ERROR] Could not create startup shortcut
)

echo.
echo   Press any key to close this installer...
pause >nul
