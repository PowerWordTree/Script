::@author FB
::@version 0.2.0

::子项列表
::  参数1: 实例名称
::  返回@: 子项列表(格式: ;child1;child2;...;childN;)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET "@RESULT=;"
SET @CMD=CALL SET "@RESULT=%%@RESULT%%{0};"
CALL Object.ForEachChild.CMD "%~1" - "@CMD"
ENDLOCAL & SET "@=%@RESULT%"
EXIT /B
