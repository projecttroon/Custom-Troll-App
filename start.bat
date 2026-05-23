@echo off
title Start Application
color 0A

echo =====================================
echo         START APPLICATION
echo =====================================
echo.

:: Check if node_modules exists
if not exist "node_modules" (
    echo ERROR: Dependencies are not installed.
    echo.
    echo Please run:
    echo npm install
    echo.
    pause
    exit
)

set /p confirm=Do you want to open the app? (Y/N): 

if /I "%confirm%"=="Y" goto startapp
if /I "%confirm%"=="N" exit

echo Invalid option.
pause
exit

:startapp
cls
echo Launching application...
npm start

pause
