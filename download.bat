@echo off
REM Download zip
curl -L -o Python.zip https://github.com/s-rayyan/copper-python/archive/refs/heads/main.zip

REM Extract to user home
powershell -NoProfile -Command "Expand-Archive -Path 'Python.zip' -DestinationPath $env:HOMEPATH -Force"

REM Delete archive
del Python.zip

REM Add python function to PowerShell profile if not already present
powershell -NoProfile -Command ^
"if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force }; ^
if (-not (Select-String -Path $PROFILE -Pattern 'function python')) { ^
  Add-Content -Path $PROFILE -Value 'function python { & `$HOME\copper-python-main\python.ps1 @args }' ^
}"
