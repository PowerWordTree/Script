::@author FB
::@version 0.1.0

::数据组织: A.B=* A.B.C=* A.B.C.D=*
::数据访问: %A.B% !A.B.C! %A.B.C.D%
::数据遍历: CALL Object_List.CMD A "{0} {1}";
::数据销毁: CALL Object_Destroy.CMD A;

::初始化
::  参数1: 实例名称

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

FOR /F "tokens=1,* usebackq delims==" %%A IN (
  `SET "%~1." 2^>NUL`
) DO (
  SET "%%~A="
)
EXIT /B
