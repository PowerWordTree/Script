::@author FB
::@version 0.1.0

::遍历
::  参数1: 实例名称
::  参数2: 输出格式({0}键占位符, {1}值占位符)
::  输出: 格式化后的多行字符串
::  退出码: 0,执行成功; 1,执行失败;

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@SETLOCAL
@SET "@PREFIX=%~1." & SET "@CMD=%~2"
@Powershell.EXE -Command "& { Get-Item Env:${Env:@PREFIX}* | ForEach-Object {$PSItem.Name = $PSItem.Name.Substring(${Env:@PREFIX}.Length); $PSItem} | Where-Object {$PSItem.Name -match '^[^.]+$'} | Sort-Object -Property Name | ForEach-Object {${Env:@CMD} -f $PSItem.Name,$PSItem.Value}; Exit -Not $? }"
@ENDLOCAL & EXIT /B %ERRORLEVEL%
