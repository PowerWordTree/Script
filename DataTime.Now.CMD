::@author FB
::@version 0.1.0

::当前日期时间
::  返回@: 当前日期时间字符串(格式:YYYYMMDDHHNNSS)
::  错误码: 0,执行成功; 1,执行失败;

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SET "@="
FOR /F "tokens=1,* usebackq delims==" %%A IN (
  `WMIC PATH win32_operatingsystem GET LocalDateTime /VALUE ^| FIND /I "LocalDateTime="`
) DO (
  SET "@=%%~B"
)
IF "%@%" == "" EXIT /B 1
SET "@=%@:~,14%"
EXIT /B 0
