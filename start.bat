@echo off
title Start Application
color 0A

echo =====================================
echo         START APPLICATION
echo =====================================
echo.

:: Check if build folder exists
if not exist "dist" (
    echo ERROR: The application is not compiled.
    echo.
    echo Please run the build process first.
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
