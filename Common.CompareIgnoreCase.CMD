::@author FB
::@version 0.1.0

::比较两个字符串或数字(忽略大小写)
::  参数1: 字符串或数字
::  参数2: 操作符(等同IF命令)
::  参数3：字符串或数字
::  返回@: TRUE,相同; FALSE,不同;
::  退出码: 0,相同; 1,不同;

::Script:Common.IsNumber.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

CALL Common.IsNumber.CMD "%~1" && CALL Common.IsNumber.CMD "%~3" && (
  IF /I %~1 %~2 %~3 (SET "@=TRUE" & EXIT /B 0)
  SET "@=FALSE" & EXIT /B 1
) || (
  IF /I "%~1" %~2 "%~3" (SET "@=TRUE" & EXIT /B 0)
  SET "@=FALSE" & EXIT /B 1
)
