@echo off
setlocal EnableDelayedExpansion

title Troll App Build System
color 0B
mode con: cols=95 lines=32

:: CONFIG
set NODE_URL=https://nodejs.org/dist/v22.15.0/node-v22.15.0-x64.msi
set NODE_FILE=nodejs-installer.msi

:MENU
cls

echo.
echo  ========================================================================
echo                           TROLL APP BUILD SYSTEM
echo  ========================================================================
echo.
echo      [1] Download Node.js
echo      [2] Install Dependencies
echo      [3] Build Application
echo      [4] Install Dependencies ^& Build
echo      [5] Clean node_modules
echo      [6] Exit
echo.
echo  ========================================================================
echo.

set /p choice= ^> Select an option: 

if "%choice%"=="1" goto DOWNLOAD_NODE
if "%choice%"=="2" goto INSTALL
if "%choice%"=="3" goto BUILD
if "%choice%"=="4" goto ALL
if "%choice%"=="5" goto CLEAN
if "%choice%"=="6" exit

goto MENU


:DOWNLOAD_NODE
cls
echo.
echo  ========================================================================
echo                        DOWNLOADING NODE.JS
echo  ========================================================================
echo.
echo  Downloading latest Node.js installer...
echo.

powershell -Command "Invoke-WebRequest -Uri '%NODE_URL%' -OutFile '%NODE_FILE%'"

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Failed to download Node.js
    pause
    goto MENU
)

echo.
echo  [SUCCESS] Download completed.
echo.
echo  Launching installer...
echo.

start "" "%NODE_FILE%"

echo.
pause
goto MENU


:INSTALL
cls
echo.
echo  ========================================================================
echo                      INSTALLING DEPENDENCIES
echo  ========================================================================
echo.

npm install

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] npm install failed.
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
echo  ========================================================================
echo                         BUILDING APPLICATION
echo  ========================================================================
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
echo  ========================================================================
echo                   INSTALLING AND BUILDING PROJECT
echo  ========================================================================
echo.

echo  [1/2] Installing dependencies...
npm install

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Failed to install dependencies.
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
echo  ========================================================================
echo                           PROCESS COMPLETED
echo  ========================================================================
echo.
pause
goto MENU


:CLEAN
cls
echo.
echo  ========================================================================
echo                           CLEANING PROJECT
echo  ========================================================================
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
