@echo off
REM Download zip
curl -L -o Python.zip https://github.com/s-rayyan/copper-python/archive/refs/heads/main.zip

REM Extract to user home
powershell -command "Expand-Archive -Path 'Python.zip' -DestinationPath $env:HOMEPATH -Force"

REM Delete archive
del Python.zip

REM Add python function to PowerShell profile
powershell -NoProfile -Command ^
"if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force }; ^
Add-Content -Path $PROFILE -Value 'function python { & `$HOME\copper-python-main\python.ps1 @args }'"
