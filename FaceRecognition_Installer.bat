@echo off
setlocal EnableDelayedExpansion
title Face Recognition Installer
color 0A

echo ========================================
echo    Face Recognition App Installer
echo          Version 1.0
echo ========================================
echo.

REM Set installation directory
set "INSTALL_DIR=%USERPROFILE%\AppData\Local\FaceRecognition"
set "DESKTOP=%USERPROFILE%\Desktop"

echo Installation will be located at:
echo %INSTALL_DIR%
echo.

REM Check if git is installed
echo [1/8] Checking Git installation...
git --version >nul 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Git is not installed!
    echo Please install Git from https://git-scm.com/
    echo.
    pause
    exit /b 1
)
echo ✓ Git found

REM Check if Python 3.10 is available
echo [2/8] Checking Python 3.10...
py -3.10 --version >nul 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Python 3.10 is not installed!
    echo Please install Python 3.10 from https://python.org/
    echo.
    pause
    exit /b 1
)
echo ✓ Python 3.10 found

REM Create installation directory
echo [3/8] Creating installation directory...
if exist "%INSTALL_DIR%" (
    echo Removing existing installation...
    rmdir /s /q "%INSTALL_DIR%"
)
mkdir "%INSTALL_DIR%"
cd /d "%INSTALL_DIR%"
echo ✓ Directory created

echo [4/9] Downloading application from GitHub...
git clone https://github.com/Vietpn1909/Face_Recognize.git .
if !errorlevel! neq 0 (
    echo ERROR: Failed to download application!
    pause
    exit /b 1
)
echo ✓ Download completed

echo [5/9] Creating required directories...
if not exist "photo" mkdir photo
if not exist "data" mkdir data
if not exist "reports" mkdir reports
echo ✓ Directories created

echo [6/9] Creating virtual environment...
py -3.10 -m venv venv
if !errorlevel! neq 0 (
    echo ERROR: Failed to create virtual environment!
    pause
    exit /b 1
)
echo ✓ Virtual environment created

echo [7/9] Installing dependencies...
call venv\Scripts\activate
python -m pip install --upgrade pip --quiet
echo Downloading dlib wheel (this may take a moment)...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/z-mahmud22/Dlib_Windows_Python3.x/raw/main/dlib-19.22.99-cp310-cp310-win_amd64.whl' -OutFile 'dlib-19.22.99-cp310-cp310-win_amd64.whl'"
pip install dlib-19.22.99-cp310-cp310-win_amd64.whl --quiet
del dlib-19.22.99-cp310-cp310-win_amd64.whl 2>nul
if !errorlevel! neq 0 (
    echo ERROR: Failed to install dlib!
    pause
    exit /b 1
)
pip install -r requirements.txt --quiet
if !errorlevel! neq 0 (
    echo ERROR: Failed to install requirements!
    pause
    exit /b 1
)
echo ✓ Dependencies installed

echo [8/9] Creating application launcher...
REM Create the hidden launcher script
(
echo @echo off
echo cd /d "%INSTALL_DIR%"
echo call venv\Scripts\activate
echo start /min "" venv\Scripts\pythonw.exe gui_app.py
) > "%INSTALL_DIR%\launch_app.bat"

REM Create VBS script for silent launch
(
echo Set objShell = CreateObject^("WScript.Shell"^)
echo objShell.CurrentDirectory = "%INSTALL_DIR%"
echo objShell.Run """%INSTALL_DIR%\venv\Scripts\pythonw.exe"" ""%INSTALL_DIR%\gui_app.py""", 0, False
) > "%INSTALL_DIR%\launch_silent.vbs"

echo ✓ Launcher created

echo [9/9] Creating desktop shortcut...
REM Create desktop shortcut using VBS
(
echo Set objShell = CreateObject^("WScript.Shell"^)
echo Set objShortcut = objShell.CreateShortcut^("%DESKTOP%\Face Recognition.lnk"^)
echo objShortcut.TargetPath = "%INSTALL_DIR%\launch_silent.vbs"
echo objShortcut.WorkingDirectory = "%INSTALL_DIR%"
echo objShortcut.Description = "Face Recognition Application"
echo objShortcut.Save
) > temp_shortcut.vbs
cscript //nologo temp_shortcut.vbs
del temp_shortcut.vbs
echo ✓ Desktop shortcut created

REM Create uninstaller
echo Creating uninstaller...
(
echo @echo off
echo title Face Recognition Uninstaller
echo echo ========================================
echo echo    Face Recognition App Uninstaller
echo echo ========================================
echo echo.
echo echo This will completely remove Face Recognition App from your computer.
echo echo Installation folder: %INSTALL_DIR%
echo echo.
echo set /p confirm="Are you sure you want to uninstall? (y/N): "
echo if /i not "%%confirm%%"=="y" (
echo     echo Uninstall cancelled.
echo     pause
echo     exit /b 0
echo )
echo echo.
echo echo Removing application files...
echo taskkill /f /im python.exe /t 2^>nul
echo taskkill /f /im pythonw.exe /t 2^>nul
echo timeout /t 2 /nobreak ^>nul
echo cd /d "%%USERPROFILE%%"
echo if exist "%INSTALL_DIR%" rmdir /s /q "%INSTALL_DIR%"
echo echo Removing desktop shortcut...
echo if exist "%DESKTOP%\Face Recognition.lnk" del "%DESKTOP%\Face Recognition.lnk"
echo echo.
echo echo ========================================
echo echo     Uninstall completed successfully!
echo echo ========================================
echo echo The Face Recognition App has been removed from your computer.
echo pause
) > "%INSTALL_DIR%\Uninstall.bat"
echo ✓ Uninstaller created

echo.
echo ========================================
echo     Installation completed successfully!
echo ========================================
echo.
echo Installation Details:
echo • Application folder: %INSTALL_DIR%
echo • Desktop shortcut: Face Recognition.lnk
echo • To uninstall: Run Uninstall.bat in app folder
echo.
echo You can now use the "Face Recognition" shortcut on your desktop!
echo.

REM Show completion message
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Face Recognition App has been installed successfully!`n`nDesktop shortcut created: Face Recognition`nInstallation folder: %INSTALL_DIR%`n`nClick OK to close installer.', 'Installation Complete', 'OK', 'Information')"

pause