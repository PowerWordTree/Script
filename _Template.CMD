::ScriptNameScriptNameScriptName
::@Authors FB
::@Version 0.1.0
::@Description
::  Description Description Description
::@Variables
::  @, @STR, @EXIT_CODE
::@Syntax
::  xxx.cmd [arg1] [arg2] [/OPT1 data]
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
SET "_NOWAIT=%_ARG.OPTION.NoWait%"
IF /I NOT "%_ARG.OPTION.NoAnsi%" == "TRUE" (
  CALL Common.AnsiEscape.CMD "True"
) ELSE (
  CALL Common.AnsiEscape.CMD "False"
)
IF /I NOT "%_ARG.OPTION.NoLogo%" == "TRUE" CALL :SHOW_LOGO
IF /I "%_ARG.OPTION.H%" == "TRUE" (
  CALL :SHOW_HELP
  GOTO :EXIT
)
IF "%_ARG.OPTION.O%" == "1" (
  SET "_OPTION=/D 1 /T 0"
  SET "_NOWAIT=TRUE"
) ELSE IF "%_ARG.OPTION.O%" == "2" (
  SET "_OPTION=/D 2 /T 0"
  SET "_NOWAIT=TRUE"
) ELSE IF "%_ARG.OPTION.O%" == "3" (
  SET "_OPTION=/D 3 /T 0"
  SET "_NOWAIT=TRUE"
) ELSE (
  SET "_OPTION="
)
IF "%_ARG.PARAM.0%" == "" (
  SET "_CONFIG=%~dpn0.ini"
) ELSE IF /I "%_ARG.PARAM.0:~-4%" == ".ini" (
  SET "_CONFIG=%_ARG.PARAM.0%"
) ELSE (
  SET "_CONFIG=%_ARG.PARAM.0%.ini"
)
CALL Path.GetAbsolutePath.CMD "%%_CONFIG%%"
SET "_CONFIG=%@%"
::选择菜单
CALL :SHOW_MENU
CHOICE /C:123 %_OPTION% /M "请选择:"
IF "%ERRORLEVEL%" == "1" (
  SET "_OPTION=MAKE_LINK"
) ELSE IF "%ERRORLEVEL%" == "2" (
  SET "_OPTION=UNDO_LINK"
) ELSE (
  GOTO :EXIT
)
::读取配置文件
CALL :ECHO_LIGHT 配置文件: %%_CONFIG%%
IF NOT EXIST "%_CONFIG%" (
  CALL :ECHO_ERROR ***** 错误: 配置文件不存在! *****
  SET /A "_EXIT_CODE=-1"
  GOTO :EXIT
)
CALL Path.GetPath.CMD "%%_CONFIG%%"
CD /D "%@%"
CALL Config.FileRead.CMD "_CONFIG" "%%_CONFIG%%"
::检查管理员权限
CALL Common.IsAdmin.CMD || (
  CALL :ECHO_ERROR ***** 错误: 需要管理员权限! *****
  SET /A "_EXIT_CODE=-1"
  GOTO :EXIT
)
::遍历执行
CALL Map.ListChild.CMD "_CONFIG"
FOR %%A IN (%@%) DO (
  CALL :READ_SECTION "%%~A"
  CALL :SHOW_SECTION "%%~A"
  CALL :%_OPTION% || SET /A "_EXIT_CODE+=1"
)
::退出
:EXIT
IF "%_ARG.OPTION.O%" == "" (
  ECHO.
  ECHO 按任意键结束……
  PAUSE >NUL
)
ENDLOCAL & EXIT /B %_EXIT_CODE%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::输出Logo
::@Outputs
::  STDOUT: 帮助
:SHOW_LOGO
ECHO.
ECHO ============================================
ECHO =======         符号链接管理         =======
ECHO ============================================
GOTO :EOF

::输出Help
::@Outputs
::  STDOUT: 帮助
:SHOW_HELP
ECHO.
ECHO 命令行: %~nx0 [配置文件[.ini]] [/o^|-o ^<1^|2^|3^>]
ECHO   [/NoWait^|-NoWait] [/NoLogo^|-NoLogo] [/NoAnsi^|-NoAnsi] [/h^|-h]
ECHO.
ECHO - 配置文件
ECHO   指定配置文件路径, 可以省略`.ini`.
ECHO   默认配置文件`%~n0.ini`.
ECHO.
ECHO - /o ^| -o
ECHO   指定要执行的操作.
ECHO   必选参数: `1`创建符号链接, `2`移除符号链接, `3`退出.
ECHO   默认操作为等待用户选择.
ECHO.
ECHO - /NoWait ^| -NoWait
ECHO   执行结束时无等待.
ECHO.
ECHO - /NoLogo ^| -NoLogo
ECHO   执行前不显示Logo.
ECHO.
ECHO - /NoAnsi ^| -NoAnsi
ECHO   禁用转义序列显示.
ECHO.
ECHO - /h ^| -h
ECHO   显示帮助
ECHO.
GOTO :EOF

::输出Menu
::@Outputs
::  STDOUT: 菜单
::  STDERR: 警告信息
:SHOW_MENU
ECHO.
CALL :ECHO_WARNING ***** 注意: 错误操作可能破坏系统! *****
ECHO.
ECHO 1:创建符号链接
ECHO 2:移除符号链接
ECHO 3:退出
ECHO.
GOTO :EOF

::输出高亮文本
::@Arguments
::  %*: 文本
::@Outputs
::  STDOUT: 高亮文本
:ECHO_LIGHT
ECHO.
ECHO %ANSI_LIGHT%%*%ANSI_RESET%
GOTO :EOF

::输出成功文本
::@Arguments
::  %*: 文本
::@Outputs
::  STDOUT: 成功文本
:ECHO_SUCCESS
ECHO.
ECHO %ANSI_FG_BRIGHT_GREEN%%*%ANSI_RESET%
GOTO :EOF

::输出跳过文本
::@Arguments
::  %*: 文本
::@Outputs
::  STDOUT: 跳过文本
:ECHO_SKIP
ECHO.
ECHO %ANSI_FG_BRIGHT_BLUE%%*%ANSI_RESET%
GOTO :EOF

::输出警告文本
::@Arguments
::  %*: 文本
::@Outputs
::  STDERR: 警告文本
:ECHO_WARNING
ECHO.
1>&2 ECHO %ANSI_FG_BRIGHT_YELLOW%%*%ANSI_RESET%
GOTO :EOF

::输出错误文本
::@Arguments
::  %*: 文本
::@Outputs
::  STDERR: 错误文本
:ECHO_ERROR
ECHO.
1>&2 ECHO %ANSI_FG_BRIGHT_YELLOW%%ANSI_BG_RED%%*%ANSI_RESET%
GOTO :EOF
