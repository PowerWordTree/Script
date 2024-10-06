::@author FB
::@version 0.2.0

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

::命令回调
::  参数N: 回调命令行
::    指定的命令及参数, 回调命令行会被直接执行.
::    使用`CALL`命令调用时, 参数不能包含`&`和`|`, 除非包裹在`"`中.
::    如果参数1为`-`时, 则参数2为保存回调命令的变量名.
::  退出码: 0,执行成功; 1,执行失败;

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

VERIFY 1>NUL 2>&1
IF NOT "%~1" == "-" (
  %*
  EXIT /B
)
SETLOCAL ENABLEDELAYEDEXPANSION
SET "@=!%~2!"
ENDLOCAL & %@%
EXIT /B
