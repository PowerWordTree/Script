::@author FB
::@version 0.1.0

::��������
::  ����1: ʵ������
::  ����2: �����ʽ({0}����ռλ��)
::  ���: ��ʽ����Ķ����ַ���
::  �˳���: 0,ִ�гɹ�; 1,ִ��ʧ��;

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@SETLOCAL
@SET "@PREFIX=%~1." & SET "@FMT=%~2"
@Powershell.EXE -Command "& { Get-Item Env:${Env:@PREFIX}@CHILD -ErrorAction Ignore | ForEach-Object Value | ForEach-Object {$PSItem.Split(';',[StringSplitOptions]::RemoveEmptyEntries)} | ForEach-Object {${Env:@FMT} -f $PSItem,''}; Exit -Not $? }"
@ENDLOCAL & EXIT /B %ERRORLEVEL%