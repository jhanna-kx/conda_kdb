
if exist %QLIC%\kc.lic (  
 copy /Y %QLIC%\kc.lic "%QHOME%"
) else (
 if exist %QLIC%\k4.lic (
  copy /Y %QLIC%\k4.lic "%QHOME%"
 ) else (
  echo "No kc.lic/k4.lic" 
  exit /b 1
 ) 
)
"%SCRIPTS%\q.bat" test.q -s 2 
