::ScriptNameScriptNameScriptName
::@Authors FB
::@Version 0.1.0
::@Description
::  Description Description Description
::@Variables
::  @, @STR, @EXIT_CODE
::@Syntax
::  xxx.cmd [arg1] [/option1 data]
::@Arguments
::  %1: arg1arg1
::  %2: arg2arg2
::    arg2arg2arg2arg2arg2arg2
::  OPT1: opt1opt1opt1
::    opt1opt1opt1opt1opt1opt1
::  OPT2: opt2opt2opt2
::@Outputs
::  %@%: outputoutputoutput
::  %@LIST%: listlistlistlist
::  FILE: filefilefilefilefile
::    filefilefilefilefilefilefilefilefilefile
::  STDOUT: stdoutstdoutstdoutstdout
::    stdoutstdoutstdoutstdoutstdoutstdoutstdout
::  STDERR: stderrstderrstderrstderr
::@Returns
::  0: returnreturnreturnreturn
::  1: returnreturnreturnreturn
::    returnreturnreturnreturn
::  N: returnreturnreturnreturn
::@Examples
::  C:\>examplesexamplesexamples
::  C:\>examplesexamplesexamplesexamples
::  examplesexamplesexamplesexamplesexamplesexamples
::@Notes
::  notesnotesnotesnotesnotesnotesnotesnotes
::  notesnotesnotes:
::    notesnotesnotesnotesnotesnotes
::    notesnotesnotesnotesnotesnotesnotesnotes
::  notesnotesnotesnotesnotesnotes
::  notesnotesnotesnotesnotesnotesnotesnotesnotesnotes

::Bin:XXXXX.EXE::
::Script:XXX.XXXX.CMD::
::File:XXXX.XXX::
::Folder:XXXXX::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::初始化环境
@ECHO OFF
SETLOCAL
SET "PATH=%~dp0Bin;%~dp0Script;%PATH%"
SET "_EXIT_CODE=0"
::解析参数
CALL Argument.Parser.CMD "_ARG" %*
IF "%_ARG.OPTION.O%" == "1" (
  SET "_OPTION=/D 1 /T 0"
) ELSE IF "%_ARG.OPTION.O%" == "2" (
  SET "_OPTION=/D 2 /T 0"
) ELSE IF "%_ARG.OPTION.O%" == "3" (
  SET "_OPTION=/D 3 /T 0"
) ELSE (
  SET "_OPTION="
)
SET "_NOWAIT=%_ARG.OPTION.NoWait%"
IF "%_ARG.PARAM.0%" == "" (
  SET "_CONFIG=%~dpn0.ini"
  SET "_CONFIG_OLD=%~dpn0.old"
) ELSE IF /I "%_ARG.PARAM.0:~-4%" == ".ini" (
  SET "_CONFIG=%_ARG.PARAM.0%"
  SET "_CONFIG_OLD=%_ARG.PARAM.0:~,-4%.old"
) ELSE (
  SET "_CONFIG=%_ARG.PARAM.0%.ini"
  SET "_CONFIG_OLD=%_ARG.PARAM.0%.old"
)
::输出帮助
IF /I "%_ARG.OPTION.H%" == "TRUE" (
  ECHO.
  ECHO %~nx0 [配置文件[.ini]] [/o^|-o ^<1^|2^|3^>] [/NoWait^|-NoWait] [/h^|-h]
  ECHO.
  ECHO - 配置文件
  ECHO   指定配置文件路径, 可以省略`.ini`.
  ECHO   备份文件会根据配置文件名生成, 扩展名为`.old`.
  ECHO   默认配置文件`%~n0.ini`, 默认备份文件`%~n0.old`.
  ECHO.
  ECHO - /o ^| -o
  ECHO   指定要执行的操作.
  ECHO   必选参数: `1`创建符号链接, `2`移除符号链接, `3`退出.
  ECHO   默认操作为等待用户选择.
  ECHO.
  ECHO - /NoWait ^| -NoWait
  ECHO   执行结束时无等待.
  ECHO.
  ECHO - /h ^| -h
  ECHO   显示帮助
  ECHO.
  GOTO :EXIT
)
::读取配置文件
ECHO.
CALL Common.Echo.CMD "1" "配置文件: %_CONFIG%"
IF NOT EXIST "%_CONFIG%" (
  ECHO.
  CALL Common.Echo.CMD "93;41" "***** 错误: 配置文件不存在! *****"
  SET /A "_EXIT_CODE=-1"
  GOTO :EXIT
)
CALL Path.GetAbsolutePath.CMD "%%_CONFIG%%"
SET "_CONFIG=%@%"
CALL Path.GetPath.CMD "%%_CONFIG%%"
CD /D "%@%"
CALL Config.FileRead.CMD "_CONFIG" "%%_CONFIG%%"
::检查管理员权限
CALL Common.IsAdmin.CMD || (
  ECHO.
  CALL Common.Echo.CMD "93;41" "***** 错误: 需要管理员权限! *****"
  SET /A "_EXIT_CODE=-1"
  GOTO :EXIT
)
::主要功能
codecodecodecodecode
codecodecodecodecodecodecodecode
codecodecode
::初始化阶段没有切换脚本所在目录, 后期可以根据需要进行工作目录切换.
::设置PATH和_CONFIG变量使用%~dp0作为基准, 避免直接管理员运行时找不到文件.
::读取配置文件时, 可选获取绝对路径, 避免切换工作目录后找不到文件.
::配置文件可能包含相对路径或%CD%变量, 需要切换工作目录到配置文件所在路径.
codecodecodecodecodecodecodecodecodecode
codecodecodecodecode
codecodecode
::退出
:EXIT
IF /I NOT "%_NOWAIT%" == "TRUE" (
  ECHO.
  ECHO 按任意键结束……
  PAUSE >NUL
)
ENDLOCAL & EXIT /B %_EXIT_CODE%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:XXXXXX
codecodecodecodecode
codecodecodecodecodecodecodecode
codecodecode
codecodecodecodecodecodecodecodecodecode
codecodecodecodecode
codecodecode
GOTO :EOF

:XXXXXX
codecodecodecodecode
codecodecodecodecodecodecodecode
codecodecode
codecodecodecodecodecodecodecodecodecode
codecodecodecodecode
codecodecode
GOTO :EOF
