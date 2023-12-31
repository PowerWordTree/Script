::@author FB
::@version 0.1.0

::日期时间格式化
::  参数1: 格式字符串
::    YYYY,年(4位); YY,年(2位);
::    MM,月(有0填充); M,月(无0填充);
::    DD,日(有0填充); D,日(无0填充);
::    HH,时(有0填充); H,时(无0填充);
::    NN,分(有0填充); N,分(无0填充);
::    SS,秒(有0填充); S,秒(无0填充);
::  参数2: 指定日期时间
::    忽略为当前日期时间.
::    格式: YYYYMMDDHHNNSS
::  返回@: 日期时间字符串

::Script:DataTime.Now.CMD::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL
SET "@=%~2"
IF "%@%" == "" CALL DataTime.Now.CMD
SET "@DATATIME=%@%"
SET "@=%~1"
CALL SET "@=%%@:YYYY=%@DATATIME:~0,4%%%"
CALL SET "@=%%@:YY=%@DATATIME:~2,2%%%"
CALL SET "@=%%@:MM=%@DATATIME:~4,2%%%"
SET /A "@STR=1%@DATATIME:~4,2%-100" 1>NUL 2>&1
CALL SET "@=%%@:M=%@STR%%%"
CALL SET "@=%%@:DD=%@DATATIME:~6,2%%%"
SET /A "@STR=1%@DATATIME:~6,2%-100" 1>NUL 2>&1
CALL SET "@=%%@:D=%@STR%%%"
CALL SET "@=%%@:HH=%@DATATIME:~8,2%%%"
SET /A "@STR=1%@DATATIME:~8,2%-100" 1>NUL 2>&1
CALL SET "@=%%@:H=%@STR%%%"
CALL SET "@=%%@:NN=%@DATATIME:~10,2%%%"
SET /A "@STR=1%@DATATIME:~10,2%-100" 1>NUL 2>&1
CALL SET "@=%%@:N=%@STR%%%"
CALL SET "@=%%@:SS=%@DATATIME:~12,2%%%"
SET /A "@STR=1%@DATATIME:~12,2%-100" 1>NUL 2>&1
CALL SET "@=%%@:S=%@STR%%%"
ENDLOCAL & SET "@=%@%"
EXIT /B
