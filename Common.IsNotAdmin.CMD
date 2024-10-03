::@author FB
::@version 0.1.0

::判断非管理员权限
::  返回@: TRUE,无权限; FALSE,有权限;
::  退出码: 0,无权限; 1,有权限;

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

NET SESSION 1>NUL 2>&1
IF NOT "%ERRORLEVEL%" == "0" (
  SET "@=TRUE"
  EXIT /B 0
) ELSE (
  SET "@=FALSE"
  EXIT /B 1
)
