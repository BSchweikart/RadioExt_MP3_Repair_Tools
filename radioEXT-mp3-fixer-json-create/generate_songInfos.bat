@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"

:: -------------------------------
:: Friendly Header
:: -------------------------------
echo.
echo ===============================================
echo   📄 songInfos.json Generator - RadioExt Mod
echo ===============================================
echo  This script scans your cleaned MP3 files and
echo  creates a songInfos.json file for your station.
echo.
echo  INPUT:  completed_files\*.mp3
echo  OUTPUT: completed_files\songInfos.json
echo  OUTPUT: logs\
echo -----------------------------------------------
echo.

:: -------------------------------
:: Log Setup
:: -------------------------------
if not exist "logs" mkdir "logs"
set "logfile=logs\generate_songInfos_bat_log.txt"
echo === songInfos.json Generation Started: %DATE% %TIME% === > "%logfile%"

:: -------------------------------
:: Folder Setup
:: -------------------------------
if not exist "completed_files" (
    mkdir "completed_files"
    echo [generate_songInfos.bat] Created completed_files folder. >> "%logfile%"
)

:: -------------------------------
:: Check for ffprobe.exe
:: -------------------------------
if not exist "ffprobe.exe" (
    echo ❌ ERROR: ffprobe.exe not found in this folder!
    echo Please make sure ffprobe.exe is next to this .bat file.
    echo [generate_songInfos.bat] Missing ffprobe.exe. >> "%logfile%"
    pause
    exit /b
)

:: -------------------------------
:: Confirm MP3s Exist
:: -------------------------------
dir /b "completed_files\*.mp3" >nul 2>&1
if errorlevel 1 (
    echo ⚠️  No MP3 files found in completed_files!
    echo Please run fix_radioEXTmp3s.bat first.
    echo [generate_songInfos.bat] No MP3s found. >> "%logfile%"
    pause
    exit /b
)

:: -------------------------------
:: Build songInfos.json with PowerShell
:: -------------------------------
echo Generating songInfos.json...

> "%temp%\generate_songInfos.ps1" (
    echo $songs = @()
    for %%f in (completed_files\*.mp3) do (
        echo $duration = & '.\ffprobe.exe' -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "completed_files\%%~nxf"
        echo $ticks = [math]::Floor([double]$duration)
        echo $songs += [PSCustomObject]@{ name = "%%~nxf"; length = $ticks }
    )
    echo $output = @{ songs = $songs }
    echo $output | ConvertTo-Json -Depth 3 | Set-Content 'completed_files\songInfos.json' -Encoding UTF8
)

powershell -ExecutionPolicy Bypass -File "%temp%\generate_songInfos.ps1" >> "%logfile%" 2>&1
del "%temp%\generate_songInfos.ps1"

:: -------------------------------
:: Result
:: -------------------------------
if exist "completed_files\songInfos.json" (
    echo ✅ songInfos.json created successfully!
    echo [generate_songInfos.bat] songInfos.json built. >> "%logfile%"
) else (
    echo ❌ Failed to create songInfos.json!
    echo [generate_songInfos.bat] Failed to generate. >> "%logfile%"
)

echo Log saved to: %logfile%
pause
endlocal
exit /b
