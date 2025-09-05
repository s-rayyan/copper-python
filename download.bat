curl -L -o Python.zip https://github.com/s-rayyan/securly-python-bypass/raw/main/Python.zip
powershell -command "Expand-Archive -Path Python.zip -DestinationPath %HOMEPATH%\Python -Force"
rmdir %HOMEPATH%\Python1 /s /q
del Python.zip
