@echo off
setlocal EnableDelayedExpansion

title Troll App Build System
color 0B
mode con: cols=90 lines=30

:MENU
cls

echo.
echo  ================================================================
echo                     TROLL APP BUILD SYSTEM
echo  ================================================================
echo.
echo      [1] Install Node Modules
echo      [2] Build Application
echo      [3] Install Modules ^& Build
echo      [4] Clean node_modules
echo      [5] Exit
echo.
echo  ================================================================
echo.

set /p choice= ^> Select an option: 

if "%choice%"=="1" goto INSTALL
if "%choice%"=="2" goto BUILD
if "%choice%"=="3" goto ALL
if "%choice%"=="4" goto CLEAN
if "%choice%"=="5" exit

goto MENU


:INSTALL
cls
echo.
echo  ================================================================
echo                    INSTALLING DEPENDENCIES
echo  ================================================================
echo.

npm install

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Failed to install dependencies.
    pause
    goto MENU
)

echo.
echo  [SUCCESS] Dependencies installed successfully.
echo.
pause
goto MENU


:BUILD
cls
echo.
echo  ================================================================
echo                       BUILDING APPLICATION
echo  ================================================================
echo.

npm run build

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Build failed.
    pause
    goto MENU
)

echo.
echo  [SUCCESS] Build completed successfully.
echo.
pause
goto MENU


:ALL
cls
echo.
echo  ================================================================
echo                 INSTALLING AND BUILDING
echo  ================================================================
echo.

echo  [1/2] Installing dependencies...
npm install

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Dependency installation failed.
    pause
    goto MENU
)

echo.
echo  [2/2] Building application...
npm run build

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Build failed.
    pause
    goto MENU
)

echo.
echo  ================================================================
echo                     PROCESS COMPLETED
echo  ================================================================
echo.
pause
goto MENU


:CLEAN
cls
echo.
echo  ================================================================
echo                     CLEANING PROJECT
echo  ================================================================
echo.

if exist node_modules (
    rmdir /s /q node_modules
    echo  [SUCCESS] node_modules removed.
) else (
    echo  [INFO] node_modules folder not found.
)

echo.
pause
goto MENU
