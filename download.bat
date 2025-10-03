@echo off
curl -L -o Python.zip https://github.com/s-rayyan/copper-python/archive/refs/heads/main.zip

powershell -NoProfile -Command "Expand-Archive -Path 'Python.zip' -DestinationPath $env:HOMEPATH -Force"

del Python.zip

powershell -NoProfile -Command ^
"if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force }; ^
Add-Content -Path $PROFILE -Value 'function python { & `$HOME\copper-python-main\python.ps1 @args }'"
