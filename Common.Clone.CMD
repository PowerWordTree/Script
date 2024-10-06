::@author FB
::@version 0.1.0

::使用延迟环境变量`!var!`展开变量或者命令`FOR`展开变量, 会忽略大部分特殊符号.
::例如:
::  C:\>SET VAR=ECHO "a & b | c" ^& ECHO true
::  C:\>ECHO %VAR%
::  ECHO "a & b | c"
::  true
::  C:\>FOR /F "usebackq delims=" %A IN (`SET VAR`) DO ECHO %A
::  VAR=ECHO "a & b | c" & ECHO true
::  C:\>ECHO !VAR!
::  ECHO "a & b | c" & ECHO true
::变量VAR中的`& ECHO true`不会被执行, 视为字符串的一部分.

::变量克隆
::  参数1: 来源变量名
::  参数2: 目标变量名

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

IF /I "%~1" == "%~2" (EXIT /B) ELSE (SET "%~2=")
FOR /F "tokens=1,* usebackq delims==" %%A IN (`SET "%~1"`) DO (
  IF /I "%%A" == "%~1" SET "%~2=%%B"
)
EXIT /B
