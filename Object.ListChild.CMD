::@author FB
::@version 0.1.0

::��������
::  ����1: ʵ������
::  ����2: �����ʽ({0}����ռλ��)
::  ���: ��ʽ����Ķ����ַ���
::  �˳���: 0,ִ�гɹ�; 1,ִ��ʧ��;

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@SETLOCAL
@SET "@PREFIX=%~1." & SET "@CMD=%~2"
@Powershell.EXE -Command "& { Get-ChildItem Env:${Env:@PREFIX}* -Name | ForEach-Object {$PSItem.Substring(${Env:@PREFIX}.Length)} | Where-Object {$PSItem -match '^[^.]+\.[^.]+$'} | ForEach-Object {$PSItem.split('.') | Select-Object -First 1} | Sort-Object -Unique | ForEach-Object {${Env:@CMD} -f $PSItem,''}; Exit -Not $? }"
@ENDLOCAL & EXIT /B %ERRORLEVEL%