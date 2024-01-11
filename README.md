# 工具脚本库

一些封装好的工具脚本, 支持脚本依赖复制.

## 约定

- 占用`@开头`变量名

  由于 CMD 脚本不支持局部变量, `SETLOCAL`也无法处理全部需求情况, 所以部分工具脚本无法保证变量名不产生冲突.

  约定工具脚本总是占用`@开头`变量名, 调用前需要确认是否冲突.

- 返回结果到`%@%`变量中

  由于 CMD 脚本输出到变量需要调用`FOR /F`, 非常麻烦.

  约定工具脚本总是返回结果到`%@%`变量中, 且`%@%`变量不受保护, 即使没有返回结果也可能影响`%@%`变量.

- 变量名不包含特殊符号

  有时需要变量名作为参数, 无法顾及变量名是否包含特殊符号(如展开变量等操作).

  约定工具脚本涉及的变量名不包含特殊符号(如`%`,`!`,`&`,`|`,`*`,`?`等), 以免造成意料外错误.

- 已经尽量避免展开变量

  由于延缓环境变量功能对`!`的处理不好, 经常造成丢失和错误解析等问题.

  约定工具脚本尽量避免展开变量, 能更灵活控制变量展开, 避免错误展开变量.

## 使用方法

可以在 CMD 脚本中直接调用, 也可以合并到 CMD 脚本标签段调用.

### 直接调用

复制文件时, 需要注意工具脚本的依赖.

```bat
::run.cmd

::引入脚本依赖工具用注释(非必须)
::Script:String.Replace.CMD::

::工具脚本路径加入到PATH中
SET "PATH=%~dp0Bin;%~dp0Script;%PATH%"

::变量展开调用
CALL String.Replace.CMD "%~1" "QAQ" "%_NEW_STR%"
ECHO %@%

::变量不展开调用
SET "_STR=%~1"
CALL String.Replace.CMD "%%_STR%%" "QAQ" "%%_NEW_STR%%"
ECHO %@%
```

### 标签调用

合并文件时, 需要注意工具脚本的依赖.

注意, 需要手动修改相关 CALL 语句.

```bat
ECHO ::::::::::::::::::::::::::::  >>run.cmd
ECHO :STRING_REPLACE >>run.cmd
TYPE String.Replace.CMD | FINDSTR /R /C:"^ *::" /C:"^ *$" >>run.cmd
```

```bat
::run.cmd

::变量展开调用
CALL :STRING_REPLACE "%~1" "QAQ" "%_NEW_STR%"
ECHO %@%

::变量不展开调用
SET "_STR=%~1"
CALL :STRING_REPLACE "%%_STR%%" "QAQ" "%%_NEW_STR%%"
ECHO %@%
```