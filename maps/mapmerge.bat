@echo off

if [%1]==[] goto usage
python mapmerge.py %1
goto :end
:usage
@echo Usage: Drag *.dmm files onto this batch file to mapmerge them!
:end
@echo.
pause

