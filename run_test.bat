
if exist %LICDIR%\kc.lic (  
 copy /Y %LICDIR%\kc.lic %QHOME%
) else (
 if exist %LICDIR%\k4.lic (
  copy /Y %LICDIR%\k4.lic %QHOME%
 ) else (
  echo "No kc.lic/k4.lic" 
  exit /b 1
 ) 
)
%SCRIPTS%\q test.q -s 2 
