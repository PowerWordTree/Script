::@author FB
::@version 0.1.0

::ת��Powershell����:
:: ^ ^^  | ^|  & ^&  < ^<  > ^>  % %%  " """  ` ^`  , ^,  ; ^;  = ^=  ( ^(  ) ^)

::����MessageBox����
::  ����1: �����ı�
::  ����2: �����ı�
::  ����3: ��ť����
::    OK(0):��Ϣ�����"ȷ��"��ť.
::    OKCancel(1):��Ϣ�����"ȷ��"��"ȡ��"��ť.
::    AbortRetryIgnore(2):��Ϣ�����"��ֹ"��"����"��"����"��ť.
::    YesNoCancel(3):��Ϣ�����"��"��"��"��"ȡ��"��ť.
::    YesNo(4):��Ϣ�����"��"��"��"��ť.
::    RetryCancel(5):��Ϣ�����"����"��"ȡ��"��ť.
::    CancelTryContinue(6):ָ����Ϣ�����"ȡ��"��"����"��"����"��ť.
::  ����4: ͼ�����
::    None(0):�������κη���.
::    Error/Hand/Stop(16):��ɫ����ԲȦ�еİ�ɫX��ɵķ���.
::    Question(32):ԲȦ�е��ʺ���ɵķ���.
::    Exclamation/Warning(48):��ɫ�����������еĸ�̾����ɵķ���.
::    Asterisk/Information(64):ԲȦ�е�Сд��ĸi��ɵķ���.
::  ����@: ���ض���
::    None(0)/OK(1)/Cancel(2)/Abort(3)/Retry(4)/Ignore(5)/Yes(6)/No(7)
::      /TryAgain(10)/Continue(11)
::  �˳���: ���ض�����

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET "@TEXT=%~1" & SET "@CAPTION=%~2" & SET "@BUTTONS=%~3" & SET "@ICON=%~4"
FOR /F "usebackq delims=" %%A IN (
  `Powershell.exe -Command ^^^& {
    $ErrorActionPreference^='SilentlyContinue'^;
    Add-Type -AssemblyName System.Windows.Forms^;
    if ^(${Env:@TEXT} -eq $null^) {${Env:@TEXT}^=' '}^;
    if ^(${Env:@CAPTION} -eq $null^) {${Env:@CAPTION}^=' '}^;
    if ^(${Env:@BUTTONS} -eq $null^) {${Env:@BUTTONS}^='OK'}^;
    if ^(${Env:@ICON} -eq $null^) {${Env:@ICON}^='None'}^;
    $Result^=[System.Windows.Forms.MessageBox]::Show^(
      ${Env:@TEXT}^, ${Env:@CAPTION}^, ${Env:@BUTTONS}^, ${Env:@ICON}
    ^)^;
    Write-Output """@=$Result""","""@EXIT_CODE=$([Int]$Result)"""
  }`
) DO (
  SET "%%~A"
)
ENDLOCAL & SET "@=%@%" & EXIT /B %@EXIT_CODE%