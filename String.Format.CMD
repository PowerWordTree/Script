::@author FB
::@version 0.1.0

::�ַ�����ʽ��
::  ����1: ��ʽ�ַ���(ռλ��:{0}{1}{2}...)
::  ����N: �滻�ַ���(��������������������)
::  ����@: ��ʽ�����ַ���

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET @ARG=%* & SET "@="
FOR /F "usebackq delims=" %%A IN (
  `Powershell.EXE -NonInteractive -Command "& { $ErrorActionPreference='SilentlyContinue'; $X=Invoke-Expression ('Write-Output '+${Env:@ARG}); $X[0] -F $X[1..$X.Length] }"`
) DO (
  SET "@=%%~A"
)
ENDLOCAL & SET "@=%@%"
EXIT /B