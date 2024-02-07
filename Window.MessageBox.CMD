::@author FB
::@version 0.1.0

::转义Powershell命令:
:: ^ ^^  | ^|  & ^&  < ^<  > ^>  % %%  " """  ` ^`  , ^,  ; ^;  = ^=  ( ^(  ) ^)

::弹出MessageBox窗口
::  参数1: 内容文本
::  参数2: 标题文本
::  参数3: 按钮对象
::    OK(0):消息框包含"确定"按钮.
::    OKCancel(1):消息框包含"确定"和"取消"按钮.
::    AbortRetryIgnore(2):消息框包含"中止"和"重试"和"忽略"按钮.
::    YesNoCancel(3):消息框包含"是"和"否"和"取消"按钮.
::    YesNo(4):消息框包含"是"和"否"按钮.
::    RetryCancel(5):消息框包含"重试"和"取消"按钮.
::    CancelTryContinue(6):指定消息框包含"取消"和"重试"和"继续"按钮.
::  参数4: 图标对象
::    None(0):不包含任何符号.
::    Error/Hand/Stop(16):红色背景圆圈中的白色X组成的符号.
::    Question(32):圆圈中的问号组成的符号.
::    Exclamation/Warning(48):黄色背景三角形中的感叹号组成的符号.
::    Asterisk/Information(64):圆圈中的小写字母i组成的符号.
::  返回@: 返回对象
::    None(0)/OK(1)/Cancel(2)/Abort(3)/Retry(4)/Ignore(5)/Yes(6)/No(7)
::      /TryAgain(10)/Continue(11)
::  退出码: 返回对象码

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET "@TEXT=%~1" & SET "@CAPTION=%~2" & SET "@BUTTONS=%~3" & SET "@ICON=%~4"
SET "@=" & SET "@EXIT_CODE=0"
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
