::@author FB
::@version 0.1.0

::չ������`FOR`�ı���ʱ, ����Դ󲿷��������.
::����:
::  C:\>SET VAR=ECHO "a & b | c" ^& ECHO true
::  C:\>FOR /F "usebackq delims=" %A IN (`SET VAR`) DO ECHO %A
::  VAR=ECHO "a & b | c" & ECHO true
::�ڶ���`ECHO`���ᱻִ��, ��Ϊ�ַ�����һ����.
::ʹ���ӳٻ�������չ��`!var!`ʱ, ��ͬ��Ч��.

::������¡
::  ����1: ��Դ������
::  ����2: Ŀ�������

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

IF /I "%~1" == "%~2" (EXIT /B) ELSE (SET "%~2=")
FOR /F "tokens=1,* usebackq delims==" %%A IN (`SET "%~1"`) DO (
  IF /I "%%A" == "%~1" SET "%~2=%%B"
)
EXIT /B