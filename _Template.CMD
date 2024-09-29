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

::��ʼ������
@ECHO OFF
SETLOCAL
SET "PATH=%~dp0Bin;%~dp0Script;%PATH%"
SET "_EXIT_CODE=0"
::��������
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
::�������
IF /I "%_ARG.OPTION.H%" == "TRUE" (
  ECHO.
  ECHO %~nx0 [�����ļ�[.ini]] [/o^|-o ^<1^|2^|3^>] [/NoWait^|-NoWait] [/h^|-h]
  ECHO.
  ECHO - �����ļ�
  ECHO   ָ�������ļ�·��, ����ʡ��`.ini`.
  ECHO   �����ļ�����������ļ�������, ��չ��Ϊ`.old`.
  ECHO   Ĭ�������ļ�`%~n0.ini`, Ĭ�ϱ����ļ�`%~n0.old`.
  ECHO.
  ECHO - /o ^| -o
  ECHO   ָ��Ҫִ�еĲ���.
  ECHO   ��ѡ����: `1`������������, `2`�Ƴ���������, `3`�˳�.
  ECHO   Ĭ�ϲ���Ϊ�ȴ��û�ѡ��.
  ECHO.
  ECHO - /NoWait ^| -NoWait
  ECHO   ִ�н���ʱ�޵ȴ�.
  ECHO.
  ECHO - /h ^| -h
  ECHO   ��ʾ����
  ECHO.
  GOTO :EXIT
)
::��ȡ�����ļ�
ECHO.
CALL Common.Echo.CMD "1" "�����ļ�: %_CONFIG%"
IF NOT EXIST "%_CONFIG%" (
  ECHO.
  CALL Common.Echo.CMD "93;41" "***** ����: �����ļ�������! *****"
  SET /A "_EXIT_CODE=-1"
  GOTO :EXIT
)
CALL Path.GetAbsolutePath.CMD "%%_CONFIG%%"
SET "_CONFIG=%@%"
CALL Path.GetPath.CMD "%%_CONFIG%%"
CD /D "%@%"
CALL Config.FileRead.CMD "_CONFIG" "%%_CONFIG%%"
::������ԱȨ��
CALL Common.IsAdmin.CMD || (
  ECHO.
  CALL Common.Echo.CMD "93;41" "***** ����: ��Ҫ����ԱȨ��! *****"
  SET /A "_EXIT_CODE=-1"
  GOTO :EXIT
)
::��Ҫ����
codecodecodecodecode
codecodecodecodecodecodecodecode
codecodecode
::��ʼ���׶�û���л��ű�����Ŀ¼, ���ڿ��Ը�����Ҫ���й���Ŀ¼�л�.
::����PATH��_CONFIG����ʹ��%~dp0��Ϊ��׼, ����ֱ�ӹ���Ա����ʱ�Ҳ����ļ�.
::��ȡ�����ļ�ʱ, ��ѡ��ȡ����·��, �����л�����Ŀ¼���Ҳ����ļ�.
::�����ļ����ܰ������·����%CD%����, ��Ҫ�л�����Ŀ¼�������ļ�����·��.
codecodecodecodecodecodecodecodecodecode
codecodecodecodecode
codecodecode
::�˳�
:EXIT
IF /I NOT "%_NOWAIT%" == "TRUE" (
  ECHO.
  ECHO ���������������
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