@echo off
setlocal enabledelayedexpansion
mode con cols=66 lines=25

rem Pause at the beginning to keep the window open
echo Press any key to continue...
pause >nul

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
    set "DEL=%%a"
)

rem Check if running as administrator
net session >nul 2>&1 || (
    title Start Agnitus in administrator mode
    mode con lines=1
    call :ColorText 0C "Start Agnitus in administrator mode"
    echo.
    pause
    exit
)

echo Running as administrator. Proceeding...
:Agnitus
cls

rem ASCII art header
echo.
echo    ___              _   _       _             
echo  
echo
echo █████╗  ██████╗ ███╗   ██╗██╗████████╗██╗   ██╗███████╗
echo ██╔══██╗██╔════╝ ████╗  ██║██║╚══██╔══╝██║   ██║██╔════╝
echo ███████║██║  ███╗██╔██╗ ██║██║   ██║   ██║   ██║███████╗
echo ██╔══██║██║   ██║██║╚██╗██║██║   ██║   ██║   ██║╚════██║
echo ██║  ██║╚██████╔╝██║ ╚████║██║   ██║   ╚██████╔╝███████║
echo ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝    ╚═════╝ ╚══════╝

            
echo.
title Agnitus - %USERNAME%
echo Starting Agnitus...
echo.

call :ColorText 0B "Gathering User Information..."

rem Gather user info and output it to a file
set "outputDir=%USERPROFILE%\agnitus"
mkdir "%outputDir%" >nul 2>&1
(
    echo User Information
    echo ==================
    echo Username: %USERNAME%
    echo User Profile: %USERPROFILE%
) > "%outputDir%\unimportant_info.txt"
echo User info collected.

call :ColorText 0B "Gathering Process Information..."

rem Get running processes and output to a file
tasklist > "%outputDir%\processes.txt"
echo Process information collected.

call :ColorText 0B "Gathering Network Information..."

rem Get IP configuration and output to a file
ipconfig /all > "%outputDir%\network_info.txt"
echo Network information collected.

call :ColorText 0B "Gathering Installed Programs Information..."

rem Get installed programs and output to a file
powershell "Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Format-Table -AutoSize" > "%outputDir%\installed_programs.txt"
echo Installed programs information collected.

call :ColorText 0B "Gathering System Information..."

rem Get system information and output to a file
systeminfo > "%outputDir%\system_info.txt"
echo System information collected.

call :ColorText 0B "Gathering Environment Variables..."

rem Get environment variables and output to a file
set > "%outputDir%\environment_variables.txt"
echo Environment variables collected.

call :ColorText 0A "All information gathered successfully."
echo Output files can be found in: %outputDir%
pause
exit

:ColorText
set "Color=%~1"
set "Text=%~2"
echo.
echo !DEL! !Text! !DEL! !Text! !DEL! !Text! !DEL! !Text! !DEL! !Text! !DEL! !Text! !DEL! !Text! !DEL! !Text!
exit /b
