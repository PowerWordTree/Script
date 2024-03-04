::@author FB
::@version 0.1.0

::重试执行
::  参数1: 重试次数
::  参数2: 重试间隔
::  参数3: 回调命令行
::    仅支持能在单个参数传递的命令行.
::  参数4: 变量名
::    如果参数3为`-`时, 则参数4为保存回调命令行的变量名.
::  退出码: 0,执行成功; 1,执行失败;

::Script:Common.Clone.CMD::
::Script:Common.Sleep.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

VERIFY 1>NUL 2>&1
IF "%~3" == "-" (CALL Common.Clone.CMD "%~4" "@") ELSE (SET "@=%~3")
FOR /L %%I IN (0,1,%~1) DO (
  IF "%%~I" GTR "0" CALL Common.Sleep.CMD "%~2"
  %@% && EXIT /B
)
EXIT /B
