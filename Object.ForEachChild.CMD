::@author FB
::@version 0.1.0

::ת��Powershell����:
:: ^ ^^  | ^|  & ^&  < ^<  > ^>  % %%  " """  ` ^`  , ^,  ; ^;  = ^=  ( ^(  ) ^)

::�ص���������
::  ����1: ʵ������
::  ����2: �ص�������
::    ��֧�����ڵ����������ݵ�������.
::    ռλ��: {0}��;
::  ����3: ������
::    �������2Ϊ`-`ʱ, �����3Ϊ����ص������еı�����.
::  �˳���: 0,ִ�гɹ�; N,ʧ�ܴ���;

::Script:Common.Clone.CMD::
::Script:Process.Callback.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SET "@=0" & SET "@PREFIX=%~1."
IF "%~2" == "-" (CALL Common.Clone.CMD "%~3" "@CMD") ELSE (SET "@CMD=%~2")
FOR /F "usebackq delims=" %%A IN (
  `Powershell.exe -NonInteractive -Command ^^^& {
    $ErrorActionPreference ^= 'SilentlyContinue'^;
    $Pattern ^= [Regex]::Escape^(${Env:@PREFIX}^) + '^([^^^^.]+^)\.[^^^^.]+'^;
    $Pattern ^= '^^^^' + $Pattern + '$'^;
    Get-Item Env:${Env:@PREFIX}* ^^^| ForEach-Object {
      if ^($PSItem.Key -match $Pattern^) { $Matches[1] }
    } ^^^| Sort-Object -Unique ^^^| ForEach-Object {
      ${Env:@CMD} -f $PSItem
    }^;
  }`
) DO (
  SET "@CMD=%%A"
  CALL Process.Callback.CMD - "@CMD" || SET /A "@+=1"
)
SET "@PREFIX=" & SET "@CMD="
EXIT /B %@%