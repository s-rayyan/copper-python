@echo off
setlocal

REM Download zip
curl -L -o "%USERPROFILE%\Python.zip" https://github.com/s-rayyan/copper-python/archive/refs/heads/main.zip

REM Extract using PowerShell Expand-Archive (still need PS to unzip)
powershell -NoProfile -Command "Expand-Archive -Path '%USERPROFILE%\Python.zip' -DestinationPath '%USERPROFILE%' -Force"

REM Delete archive
del "%USERPROFILE%\Python.zip"

REM Ensure PowerShell profile directory exists
if not exist "%USERPROFILE%\Documents\WindowsPowerShell" (
    mkdir "%USERPROFILE%\Documents\WindowsPowerShell"
)

REM Ensure PowerShell profile file exists
if not exist "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" (
    type nul > "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
)

REM Check if function already exists
findstr /C:"function python" "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" >nul
if errorlevel 1 (
    echo Adding python function to profile...
    echo function python { ^& $HOME\copper-python-main\python.ps1 @args }>> "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
) else (
    echo Function already exists in profile.
)

echo Done! Restart PowerShell to use 'python'.
endlocal
pause
