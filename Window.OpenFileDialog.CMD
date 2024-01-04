::@author FB
::@version 0.1.0

::ת��Powershell����:
:: ^ ^^  | ^|  & ^&  < ^<  > ^>  % %%  " """  ` ^`  , ^,  ; ^;  = ^=  ( ^(  ) ^)

::����OpenFileDialog����
::  [/Title ����] [/Multiselect [True]] [/InitialDirectory ·��] [/Filter ����]
::  ѡ��-Title: �Ի������(Ĭ��: "��")
::  ѡ��-Multiselect: ��ѡ֧��(Ĭ��: False)
::  ѡ��-InitialDirectory: ��ʼ·��(Ĭ��: ��)
::  ѡ��-Filter: �ļ�������(Ĭ��: ��)
::    ��ʽ: �����ַ���1|�����ַ���1|�����ַ���2|�����ַ���2...
::    �����ַ���: �������˵��ַ���.
::    �����ַ���: ��ͨ����Ͳ����ļ�����ɵ��ַ���.
::    ʾ��: Image Files(*.BMP;*.JPG)|*.BMP;*.JPG|All files (*.*)|*.*
::  ����@: ���ض���
::    None(0)/OK(1)/Cancel(2)
::  �˳���: ���ض�����

::Script:Argument.Parser.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
CALL Argument.Parser.CMD "@" %*
FOR /F "usebackq delims=" %%A IN (
  `Powershell.exe -Command ^^^& {
    $ErrorActionPreference ^= 'SilentlyContinue'^;
    Add-Type -AssemblyName System.Windows.Forms^;
    $Dialog ^= New-Object System.Windows.Forms.OpenFileDialog^;
    if ^(${Env:@.Title} -ne $null^) {
      $Dialog.Title ^= ${Env:@.Title}
    }^;
    if ^(${Env:@.Multiselect} -eq 'True'^) {
      $Dialog.Multiselect ^= $true
    }^;
    if ^(${Env:@.InitialDirectory} -ne $null^) {
      $Dialog.InitialDirectory ^= ${Env:@.InitialDirectory}
    }^;
    if ^(${Env:@.Filter} -ne $null^) {
      $Dialog.Filter ^= ${Env:@.Filter}
    }^;
    if ^($Dialog.ShowDialog^(^) -eq 'OK'^) {
      $Result ^= $Dialog.FileNames.ForEach^({'"""' + $PSItem + '"""'}^)
    }^;
    $Result ^= $Result -Join """;"""^;
    Write-Output """@=$Result""","""@EXIT_CODE=$([Int] -Not $Result)"""
  }`
) DO (
  SET "%%~A"
)
ENDLOCAL & SET "@=%@%" & EXIT /B %@EXIT_CODE%