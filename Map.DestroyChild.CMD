::@author FB
::@version 0.1.0

::销毁子项
::  参数1: 实例名称
::  参数2: 子项名称

::Script:Map.Destroy.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

CALL ECHO.%%%~1.@CHILD%% | FIND /I ";%~2;" 1>NUL 2>&1 && (
  CALL SET "%~1.@CHILD=%%%~1.@CHILD:;%~2;=;%%"
  CALL Map.Destroy.CMD "%~1.%~2"
)
EXIT /B 0
