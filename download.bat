@echo off
curl -L -o Python.zip curl -L -o Python.zip https://github.com/s-rayyan/copper-python/archive/refs/heads/main.zip
powershell -command "Expand-Archive -Path Python.zip -DestinationPath %HOMEPATH%\ -Force"
del Python.zip
powershell -NoProfile -Command "& { $profile; function python { & `"$HOME\copper-python-main\python.ps1`" @args }; python %* }"

