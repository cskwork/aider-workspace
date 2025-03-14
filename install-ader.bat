@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo Aider Installation and Configuration Script
echo ===================================================
echo This script will install Aider and set up configuration files.
echo.

REM Check if Python is installed
python --version > nul 2>&1
if !errorlevel! neq 0 (
    echo Python is not installed or not in PATH. Please install Python 3.8 through 3.13.
    echo Download from: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo Python is installed. Proceeding with Aider installation...
echo.

REM Installation method selection
echo Please select your preferred installation method:
echo 1. Direct pip install (Recommended and simplest)
echo 2. pipx install (Good for keeping dependencies isolated)
echo 3. pip with virtual environment
echo.
set /p install_method=Enter your choice (1-3): 

REM Create a log file to track progress
echo Creating installation log file...
set "LOG_FILE=%~dp0aider_install.log"
echo Installation started at %date% %time% > !LOG_FILE!

if "!install_method!"=="1" (
    echo You selected: Direct pip install >> !LOG_FILE!
    echo Installing Aider using pip directly...
    echo Installing Aider using pip directly... >> !LOG_FILE!
    
    echo Command: python -m pip install -U aider-chat >> !LOG_FILE!
    python -m pip install -U aider-chat >> !LOG_FILE! 2>&1
    
    if !errorlevel! neq 0 (
        echo Error: pip install failed with code !errorlevel! >> !LOG_FILE!
        echo.
        echo There was an issue installing Aider with pip.
        echo Check the log file at !LOG_FILE! for details.
        echo.
        pause
    ) else (
        echo Aider successfully installed via pip >> !LOG_FILE!
    )
) else if "!install_method!"=="2" (
    echo You selected: pipx install >> !LOG_FILE!
    echo Installing pipx first...
    echo Installing pipx first... >> !LOG_FILE!
    
    echo Command: python -m pip install -U pipx >> !LOG_FILE!
    python -m pip install -U pipx >> !LOG_FILE! 2>&1
    
    echo Installing Aider using pipx...
    echo Command: python -m pipx install aider-chat >> !LOG_FILE!
    python -m pipx install aider-chat >> !LOG_FILE! 2>&1
    
    if !errorlevel! neq 0 (
        echo Error: pipx install failed with code !errorlevel! >> !LOG_FILE!
        echo.
        echo There was an issue installing Aider with pipx.
        echo Check the log file at !LOG_FILE! for details.
        echo.
        pause
    ) else (
        echo Aider successfully installed via pipx >> !LOG_FILE!
    )
) else if "!install_method!"=="3" (
    echo You selected: pip with virtual environment >> !LOG_FILE!
    echo Installing virtualenv...
    echo Installing virtualenv... >> !LOG_FILE!
    
    echo Command: python -m pip install virtualenv >> !LOG_FILE!
    python -m pip install virtualenv >> !LOG_FILE! 2>&1
    
    echo Creating virtual environment 'aider-env'...
    echo Command: python -m virtualenv aider-env >> !LOG_FILE!
    python -m virtualenv aider-env >> !LOG_FILE! 2>&1
    
    echo Activating virtual environment...
    echo Command: call aider-env\Scripts\activate >> !LOG_FILE!
    call aider-env\Scripts\activate >> !LOG_FILE! 2>&1
    
    echo Installing Aider in virtual environment...
    echo Command: python -m pip install -U aider-chat >> !LOG_FILE!
    python -m pip install -U aider-chat >> !LOG_FILE! 2>&1
    
    if !errorlevel! neq 0 (
        echo Error: Virtual env install failed with code !errorlevel! >> !LOG_FILE!
        echo.
        echo There was an issue installing Aider in the virtual environment.
        echo Check the log file at !LOG_FILE! for details.
        echo.
        pause
    ) else (
        echo Aider successfully installed in virtual environment >> !LOG_FILE!
        echo.
        echo To use Aider, you need to activate the virtual environment first:
        echo call aider-env\Scripts\activate
    )
) else (
    echo Invalid choice. Using the direct pip install method. >> !LOG_FILE!
    echo Installing Aider using pip directly...
    echo Command: python -m pip install -U aider-chat >> !LOG_FILE!
    python -m pip install -U aider-chat >> !LOG_FILE! 2>&1
    
    if !errorlevel! neq 0 (
        echo Error: pip install failed with code !errorlevel! >> !LOG_FILE!
        echo.
        echo There was an issue installing Aider.
        echo Check the log file at !LOG_FILE! for details.
        echo.
        pause
    ) else {
        echo Aider successfully installed via pip >> !LOG_FILE!
    }
)

echo.
echo Aider installation completed, checking if it's accessible...
where aider >nul 2>&1
if !errorlevel! neq 0 (
    echo Aider command not found in PATH. >> !LOG_FILE!
    echo.
    echo Aider command not found in PATH.
    echo You might need to:
    echo 1. Restart your command prompt
    echo 2. Add the installation directory to your PATH
    echo 3. If you used a virtual environment, activate it first
    echo.
) else (
    echo Aider command found in PATH. >> !LOG_FILE!
    echo Aider has been successfully installed and is in your PATH.
)

echo.
echo Install Playwright
playwright install --with-deps chromium

echo.
# For Mac
# brew install portaudio

echo.
echo ===================================================
echo Installation process complete!
echo ===================================================
echo.
echo To start Aider in browser mode, run:
echo   aider --browser
echo.
echo If you face any issues, please check the log file:
echo   !LOG_FILE!
echo.
echo Installation log saved to: !LOG_FILE!
echo.

pause
endlocal