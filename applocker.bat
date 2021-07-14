@ECHO OFF

set starting_path=None
::-------------------------- has argument ?
if ["%~1"]==[""] (
    ECHO Usage: applocker.bat [directory]
    ECHO Example: applocker.bat "C:\Windows"
    EXIT /B
)
::-------------------------- argument exist ?
if not exist %~s1 (
    echo The specified directory does not exist
    EXIT /B
) else (
    if exist %~s1\NUL (
        set starting_path=%1
        GOTO continue
    ) else (
        echo You specified a file, please specify a directory
        EXIT /B
    )
)

:continue
:: Setting up testfile
if NOT exist testfile.txt  (
    ECHO Creating testfile.txt
    ECHO Test file > testfile.txt
)
:: DEL "%%s\testfile.txt"

:: find subfolders
for /D /R %starting_path%  %%s in (*) do (
    copy testfile.txt "%%s" > nul 2>&1
    if exist "%%s\testfile.txt" (
        ECHO [%%s] is writable!
        DEL "%%s\testfile.txt" > nul 2>&1
        )
    ) 
)

:: Cleaning up
DEL testfile.txt
