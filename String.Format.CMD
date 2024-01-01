::@author FB
::@version 0.1.0

::字符串格式化
::  参数1: 格式字符串(占位符:{0}{1}{2}...)
::  参数N: 替换字符串(数量必须大于最大索引号)
::  返回@: 格式化后字符串

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
