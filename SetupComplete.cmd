@echo off

:: Elevate
>nul 2>&1 fsutil dirty query %systemdrive% || echo CreateObject^("Shell.Application"^).ShellExecute "%~0", "ELEVATED", "", "runas", 1 > "%temp%\uac.vbs" && "%temp%\uac.vbs" && exit /b
DEL /F /Q "%temp%\uac.vbs"

:: Move to the script directory
cd /d %~dp0

:: Move to Bin subfolder
cd Bin

:: Policy
lgpo /g ./

:: Execute msi files alphabetically
for /f "tokens=*" %%A in ('dir /b /o:n *.msi') do (
    msiexec /i "%%A" /quiet /norestart
)
