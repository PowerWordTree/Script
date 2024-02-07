::@author FB
::@version 0.1.0

::转义Powershell命令:
:: ^ ^^  | ^|  & ^&  < ^<  > ^>  % %%  " """  ` ^`  , ^,  ; ^;  = ^=  ( ^(  ) ^)

::弹出OpenFileDialog窗口
::  [/Title 标题] [/Multiselect [True]] [/InitialDirectory 路径] [/Filter 过滤]
::  选项-Title: 对话框标题(默认: "打开")
::  选项-Multiselect: 多选支持(默认: False)
::  选项-InitialDirectory: 起始路径(默认: 空)
::  选项-Filter: 文件名过滤(默认: 空)
::    格式: 描述字符串1|过滤字符串1|描述字符串2|过滤字符串2...
::    描述字符串: 描述过滤的字符串.
::    过滤字符串: 由通配符和部分文件名组成的字符串.
::    示例: Image Files(*.BMP;*.JPG)|*.BMP;*.JPG|All files (*.*)|*.*
::  返回@: 返回对象
::    None(0)/OK(1)/Cancel(2)
::  退出码: 返回对象码

::Script:Argument.Parser.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET "@=" & SET "@EXIT_CODE=0"
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
