@echo off
color 0C
echo.
echo   Removing Jarvis from startup...

set "SHORTCUT=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Jarvis.lnk"
if exist "%SHORTCUT%" del "%SHORTCUT%"

:: Kill running Jarvis processes
powershell -Command "Get-Process powershell -ErrorAction SilentlyContinue | Where-Object {$_.CommandLine -like '*HttpListener*8080*' -or $_.CommandLine -like '*PresentationFramework*orb*'} | Stop-Process -Force -ErrorAction SilentlyContinue"

echo   [OK] Jarvis removed from startup.
echo   Press any key to close...
pause >nul
