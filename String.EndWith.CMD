::@author FB
::@version 0.1.0

::判断字符串以指定字符串结尾
::  参数1: 目标字符串
::  参数2: 指定字符串
::  返回@: TRUE,是; FALSE,否;
::  退出码: 0,是; 1,否;

::Script:String.GetSize.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET "@STR=%~1"
CALL String.GetSize.CMD "%~2"
CALL SET "@STR=%%@STR:~-%@%%%"
IF /I "%@STR%" == "%~2" (
  ENDLOCAL & SET "@=TRUE"
  EXIT /B 0
) ELSE (
  ENDLOCAL & SET "@=FALSE"
  EXIT /B 1
)
