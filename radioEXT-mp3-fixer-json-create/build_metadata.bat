@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"

:: -------------------------------
:: Friendly Header
:: -------------------------------
echo.
echo ===============================================
echo     📄 Metadata Creator - RadioExt Utility
echo ===============================================
echo  This tool builds a metadata.json file using a
echo  template and your answers below.
echo.
echo  REQUIRED:
echo    - Station display name (e.g. 99.1 Chrome Dreams)
echo    - FM frequency (e.g. 99.1)
echo.
echo  OPTIONAL:
echo    - Streaming support (for live radio URLs)
echo    - Partial song order (MP3 mode only)
echo    - Custom radio icon (advanced use only)
echo -----------------------------------------------
echo.
echo  INPUT:  metadata_template\metadata.json
echo  OUTPUT: completed_files\metadata.json
echo  OUTPUT: logs\
echo -----------------------------------------------
echo.


:: -------------------------------
:: Log Setup
:: -------------------------------
if not exist "logs" mkdir "logs"
set "logfile=logs\build_metadata_bat_log.txt"
echo === Metadata Build Started: %DATE% %TIME% === > "%logfile%"

:: -------------------------------
:: Folder Setup
:: -------------------------------
if not exist "completed_files" (
    echo Creating completed_files folder...
    mkdir "completed_files"
    echo [build_metadata.bat] Created completed_files folder. >> "%logfile%"
)

if not exist "metadata_template\metadata.json" (
    echo ❌ ERROR: metadata_template\metadata.json not found!
    echo [build_metadata.bat] Missing template. >> "%logfile%"
    echo Please add a base metadata.json to:
    echo    metadata_template\metadata.json
    pause
    exit /b
)

:: -------------------------------
:: Prompt User for Inputs
:: -------------------------------
set /p displayName=Enter station display name (e.g. 99.1 Chrome Dreams):
if "%displayName%"=="" (
    echo ❌ Station name is required. Aborting.
    echo [build_metadata.bat] No station name entered. >> "%logfile%"
    pause
    exit /b
)

:ask_fm
set /p fm=Enter station FM frequency (e.g. 99.1):
echo %fm% | findstr /R "^[0-9]*\.[0-9]*$" >nul
if errorlevel 1 (
    echo ❌ Invalid FM input. Must be a number like 98.4
    goto ask_fm
)

:: Ask if streaming is being used
echo.
echo Are you using an online radio stream instead of local MP3s?
choice /M "Use streaming mode?"
if errorlevel 1 (
    set "isStream=true"
    set /p streamURL=Enter stream URL (e.g. https://example.com/live.mp3):
) else (
    set "isStream=false"
)

:: In MP3 mode: ask about song order
set "includeOrder=false"
if "!isStream!"=="false" (
    echo.
    echo OPTIONAL: You may define a custom playback order.
    echo ⚠️  Only include specific highlight tracks — NOT all MP3s.
    echo.
    choice /M "Include selected songs in order field?"
    if errorlevel 1 set "includeOrder=true"
)

:: Ask about custom icon
echo.
echo ADVANCED: Do you want to use a custom station icon?
echo (This requires a .inkatlas and manual JSON editing.)
choice /M "Use a custom icon?"
if errorlevel 1 (
    set "useCustomIconPrompt=true"
    echo [build_metadata.bat] User chose to use a custom icon. Manual editing required. >> "%logfile%"
) else (
    set "useCustomIconPrompt=false"
    echo [build_metadata.bat] Default icon will be used. >> "%logfile%"
)

:: -------------------------------
:: Build metadata.json with PowerShell
:: -------------------------------
> "%temp%\build_metadata.ps1" (
    echo $template = Get-Content 'metadata_template\metadata.json' | ConvertFrom-Json
    echo $template.displayName = "%displayName%"
    echo $template.fm = [double]"%fm%"

    if ("%isStream%" -eq "true") {
        echo $template.streamInfo.isStream = $true
        echo $template.streamInfo.streamURL = "%streamURL%"
        echo $template.order = @()
    } else {
        echo $template.streamInfo.isStream = $false
        echo $template.streamInfo.streamURL = ""
        if ("%includeOrder%" -eq "true") {
            echo $orderList = @()
            for %%f in (completed_files\*.mp3) do (
                echo $orderList += "%%~nxf"
            )
            echo $template.order = $orderList
        }
    }

    if ("%useCustomIconPrompt%" -eq "false") {
        echo $template.customIcon.useCustom = $false
    }

    echo $template | ConvertTo-Json -Depth 5 | Set-Content 'completed_files\metadata.json' -Encoding UTF8
)

powershell -ExecutionPolicy Bypass -File "%temp%\build_metadata.ps1" >> "%logfile%" 2>&1
del "%temp%\build_metadata.ps1"

:: -------------------------------
:: Result
:: -------------------------------
if exist "completed_files\metadata.json" (
    echo ✅ metadata.json successfully created!
    echo [build_metadata.bat] metadata.json built successfully. >> "%logfile%"
) else (
    echo ❌ Failed to create metadata.json!
    echo [build_metadata.bat] metadata.json failed. >> "%logfile%"
)

echo.
echo You may now open completed_files\metadata.json to review or customize.
echo Log written to: logs\build_metadata_bat_log.txt
pause
endlocal
exit /b
