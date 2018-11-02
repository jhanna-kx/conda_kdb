set ACTIVATE_DIR=%PREFIX%\etc\conda\activate.d
set DEACTIVATE_DIR=%PREFIX%\etc\conda\deactivate.d

mkdir %ACTIVATE_DIR%
mkdir %DEACTIVATE_DIR%

copy %RECIPE_DIR%\activate.bat %ACTIVATE_DIR%\kdb_activate.bat
if errorlevel 1 exit 1

copy %RECIPE_DIR%\deactivate.bat %DEACTIVATE_DIR%\kdb_deactivate.bat
if errorlevel 1 exit 1


set KX=%RECIPE_DIR%
copy %KX%\w64.zip .
if errorlevel 1 exit 1

7z x w64.zip
if errorlevel 1 exit 1

mkdir %PREFIX%\q\w64
if errorlevel 1 exit 1

move w64\q.exe %PREFIX%\q\w64
if errorlevel 1 exit 1

move q.k %PREFIX%\q
if errorlevel 1 exit 1

copy %RECIPE_DIR%\kc.lic.py %SCRIPTS%\q.py
if errorlevel 1 exit 1

copy %RECIPE_DIR%\q.bat %SCRIPTS%\q.bat
if errorlevel 1 exit 1
