::@author FB
::@version 0.1.0

::�ж��ַ�����ָ���ַ�����β
::  ����1: Ŀ���ַ���
::  ����2: ָ���ַ���
::  ����@: TRUE,��; FALSE,��;
::  �˳���: 0,��; 1,��;

::Script:String.GetSize.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET "@STR=%~1"
CALL String.GetSize.CMD "%~2"
CALL SET "@STR=%%@STR:~-%@%%%"
IF /I "%@STR%" == "%~2" (
  ENDLOCAL & SET "@=TRUE"
  EXIT /B 0
) ELSE (
  ENDLOCAL & SET "@=FALSE"
  EXIT /B 1
)
