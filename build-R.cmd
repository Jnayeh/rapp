@echo off
setlocal EnableDelayedExpansion
title LaTeX Build

REM --- Refresh PATH from Machine + User (like the PS1 did) ---
set "MACHINE_PATH="
set "USER_PATH="
for /f "usebackq tokens=2,*" %%A in (`reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul`) do set "MACHINE_PATH=%%B"
for /f "usebackq tokens=2,*" %%A in (`reg query "HKCU\Environment" /v Path 2^>nul`) do set "USER_PATH=%%B"
set "PATH=%MACHINE_PATH%;%USER_PATH%"

REM --- Move to the folder containing this .cmd ---
cd /d "%~dp0"

:outerloop

echo ==^> Cleaning auxiliary files ...
del /q *.aux *.toc *.lof *.lot *.log *.out *.bbl *.blg 2>nul

set RUNS=3
set /a I=1

:buildloop
if %I% GTR %RUNS% goto builddone

echo.
echo ==^> XeLaTeX pass %I% / %RUNS% ...
xelatex -interaction=nonstopmode -halt-on-error main.tex
if errorlevel 1 (
    echo.
    echo ERROR: XeLaTeX failed on pass %I%. Check main.log for details.
    echo.
    choice /c RC /n /m "Press R to retry, C to cancel: "
    if errorlevel 2 goto cancel
    goto outerloop
)

set /a I+=1
goto buildloop

:builddone
echo.
echo ==^> Build complete: main.pdf
echo.
choice /c RC /n /m "Press R to rebuild, C to close: "
if errorlevel 2 goto cancel
goto outerloop

:cancel
echo.
echo ==^> Exiting.
timeout /t 1 >nul
exit /b 0