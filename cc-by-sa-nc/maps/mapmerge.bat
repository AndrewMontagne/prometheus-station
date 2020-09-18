1>2# : ^
'''
@echo off
WHERE python >nul 2>nul
IF %ERRORLEVEL% NEQ 0 ECHO You don't appear to have python installed, go get Python 3.5 or newer! && PAUSE && EXIT /b
python -x "%~f0" %*
exit /b
rem ^
'''

import sys

if sys.version_info < (3, 5):
    print("Python 3.5 or newer is required!")
    exit(-1)

sys.path.append("../../mit/tools")

if len(sys.argv) <= 1:
    print('Usage: Drag one or more *.dmm files onto this batch file to mapmerge them!')
else:
    import mapmerge

input("\nPress Enter to continue...")
