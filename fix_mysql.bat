@echo off
REM MySQL Data Recovery/Restoration Script for XAMPP
REM Created by: Malith Madhuwanthe
REM GitHub: https://github.com/malithonline
REM This script automates the MySQL data folder restoration process

color 0A
cls
echo.
echo ================================================
echo    MySQL Data Recovery Script for XAMPP
echo    By: Malith Madhuwanthe
echo    GitHub: https://github.com/malithonline
echo ================================================
echo.
echo [WARNING] This will rename your current data folder!
echo.
set /p CONFIRM="Do you want to continue? (Y/N): "
if /I not "%CONFIRM%"=="Y" (
    echo.
    echo [CANCELLED] Operation cancelled by user.
    pause
    exit /b 0
)
echo.

REM Set the MySQL base directory
set MYSQL_DIR=c:\xampp\mysql

REM Generate timestamp in format YYYYMMDD_HHMMSS
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set TIMESTAMP=%datetime:~0,4%%datetime:~4,2%%datetime:~6,2%_%datetime:~8,2%%datetime:~10,2%%datetime:~12,2%
set DATA_OLD_NAME=data_old_%TIMESTAMP%

echo [1/6] Checking data folder...
if not exist "%MYSQL_DIR%\data" (
    echo [ERROR] mysql\data folder does not exist!
    pause
    exit /b 1
)

echo [2/6] Renaming data folder to %DATA_OLD_NAME%...
rename "%MYSQL_DIR%\data" %DATA_OLD_NAME% >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Failed to rename. Make sure MySQL is stopped!
    pause
    exit /b 1
)
echo       [OK] Renamed successfully


echo [3/6] Creating new data folder...
mkdir "%MYSQL_DIR%\data" >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Failed to create new data folder!
    pause
    exit /b 1
)
echo       [OK] Created successfully


echo [4/6] Copying backup contents...
if not exist "%MYSQL_DIR%\backup" (
    echo [ERROR] mysql\backup folder does not exist!
    pause
    exit /b 1
)
xcopy "%MYSQL_DIR%\backup\*" "%MYSQL_DIR%\data\" /E /I /Y /Q >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Failed to copy backup contents!
    pause
    exit /b 1
)
echo       [OK] Backup copied successfully


echo [5/6] Copying your databases...
set DB_COUNT=0
for /D %%d in ("%MYSQL_DIR%\%DATA_OLD_NAME%\*") do (
    set "folder=%%~nxd"
    setlocal enabledelayedexpansion
    if /I not "!folder!"=="mysql" (
        if /I not "!folder!"=="performance_schema" (
            if /I not "!folder!"=="phpmyadmin" (
                set /a DB_COUNT+=1
                echo       - !folder!
                xcopy "%%d" "%MYSQL_DIR%\data\!folder!\" /E /I /Y /Q >nul 2>&1
            )
        )
    )
    endlocal
)
echo       [OK] Databases copied successfully


echo [6/6] Copying ibdata1 file...
if exist "%MYSQL_DIR%\%DATA_OLD_NAME%\ibdata1" (
    copy /Y "%MYSQL_DIR%\%DATA_OLD_NAME%\ibdata1" "%MYSQL_DIR%\data\ibdata1" >nul 2>&1
    if errorlevel 1 (
        echo [WARNING] Failed to copy ibdata1 file!
    ) else (
        echo       [OK] ibdata1 copied successfully
    )
) else (
    echo [WARNING] ibdata1 file not found!
)


echo.
echo ================================================
echo         [SUCCESS] RESTORATION COMPLETED!
echo ================================================
echo.
echo [NEXT STEP] Start MySQL from XAMPP Control Panel
echo.
echo Backup saved as: %DATA_OLD_NAME%
echo.
echo ================================================
echo Created by: Malith Madhuwanthe
echo GitHub: https://github.com/malithonline
echo.
echo If this helped you, please star (*) on GitHub!
echo ================================================
echo.
pause
