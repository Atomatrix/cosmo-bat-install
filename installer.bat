@ECHO off
SETLOCAL
SET "IP_ADDRESS=127.0.0.1"
SET "HOSTS_FILE=%WinDir%\System32\drivers\etc\hosts"
SET "TEMP_HOSTS_FILE=%TEMP%\%RANDOM%__hosts"
GOTO start
:start

GOTO checkperms

:options

    ECHO Welcome to the Cosmo Installer
    ECHO Please choose an action:
    ECHO 1) Install
    ECHO 2) Uninstall
    ECHO 3) Exit
    SET /p choice=Type the number to choose an option: 

    if '%choice%'=='' (
        ECHO "%choice%" is not a valid option, try again.
        GOTO options
    )
    if '%choice%'=='1' GOTO install
    if '%choice%'=='2' GOTO uninstall
    if '%choice%'=='3' EXIT

:checkperms

    REG ADD HKLM /F>nul 2>&1
    if %ERRORLEVEL% == 0 (
        GOTO options
    ) else (
        ECHO 
        ECHO NO ADMIN PERMISSIONS
        ECHO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ECHO Please run this installer again with admin permisions.
        ECHO To do it, right click on this file and click on 
        ECHO "Run as administrator"
        PAUSE
        EXIT
    )

:install
    FINDSTR /V "\n%IP_ADDRESS% s.optifine.net" "%HOSTS_FILE%" > "%TEMP_HOSTS_FILE%"
    ECHO %IP_ADDRESS% s.optifine.net >> "%TEMP_HOSTS_FILE%"
    COPY /b/v/y "%TEMP_HOSTS_FILE%" "%HOSTS_FILE%"
    ECHO Cosmo has been installed successfully!
    PAUSE
    EXIT

:uninstall
    FINDSTR /V "%IP_ADDRESS% s.optifine.net" "%HOSTS_FILE%" > "%TEMP_HOSTS_FILE%"
    COPY /b/v/y "%TEMP_HOSTS_FILE%" "%HOSTS_FILE%"
    ECHO Cosmo has been uninstalled successfully!
    PAUSE
    EXIT
