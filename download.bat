curl -L -o Python.zip https://github.com/s-rayyan/securly-python-bypass/raw/main/Python.zip
powershell -command "Expand-Archive -Path Python.zip -DestinationPath %HOMEPATH%\Python1 -Force"
move %HOMEPATH%\Python1\securly-python-bypass-main %HOMEPATH%\Python
rmdir %HOMEPATH%\Python1 /s /q
del Python.zip
