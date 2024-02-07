::@author FB
::@version 0.2.0

::全部列表
::  参数1: 实例名称
::  返回@: 键列表(格式: ;key1;key2;...;keyN;)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET "@RESULT=;"
SET @CMD=CALL SET "@RESULT=%%@RESULT%%{0};"
CALL Object.ForEachAll.CMD "%~1" - "@CMD"
ENDLOCAL & SET "@=%@RESULT%"
EXIT /B
