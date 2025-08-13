@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"

:: -------------------------------
:: Friendly Header
:: -------------------------------
echo.
echo ===============================================
echo   🎵 MP3 Cleaner for Cyberpunk RadioExt Mod
echo ===============================================
echo  This utility prepares your MP3s for the mod by:
echo   - Re-encoding at 320kbps
echo   - Stripping metadata
echo   - Writing XING headers
echo.
echo  INPUT:  mp3s_to_fix\
echo  OUTPUT: completed_files\
echo  OUTPUT: logs\
echo -----------------------------------------------
echo.

:: -------------------------------
:: Log Setup
:: -------------------------------
if not exist "logs" mkdir "logs"
set "logfile=logs\fix_radioEXTmp3s_bat_log.txt"
echo === MP3 Cleanup Started: %DATE% %TIME% === > "%logfile%"

:: -------------------------------
:: Folder Setup
:: -------------------------------
if not exist "mp3s_to_fix" (
    mkdir "mp3s_to_fix"
    echo [fix_radioEXTmp3s.bat] Created mp3s_to_fix folder. >> "%logfile%"
)

if not exist "completed_files" (
    mkdir "completed_files"
    echo [fix_radioEXTmp3s.bat] Created completed_files folder. >> "%logfile%"
)

:: -------------------------------
:: Check for ffmpeg.exe
:: -------------------------------
if not exist "ffmpeg.exe" (
    echo ❌ ERROR: ffmpeg.exe not found in script folder!
    echo [fix_radioEXTmp3s.bat] Missing ffmpeg.exe. >> "%logfile%"
    echo Please place ffmpeg.exe next to this .bat file.
    pause
    exit /b
)

:: -------------------------------
:: Confirm MP3s Exist
:: -------------------------------
dir /b "mp3s_to_fix\*.mp3" >nul 2>&1
if errorlevel 1 (
    echo ⚠️  No MP3 files found in mp3s_to_fix!
    echo Please add your .mp3 files to the folder.
    echo Then re-run this script.
    echo [fix_radioEXTmp3s.bat] No MP3s found. >> "%logfile%"
    pause
    exit /b
)

:: -------------------------------
:: Confirm to Continue
:: -------------------------------
echo Found MP3 files in mp3s_to_fix.
echo Press any key to begin processing...
pause >nul

:: -------------------------------
:: Process MP3s
:: -------------------------------
for %%f in ("mp3s_to_fix\*.mp3") do (
    echo Processing: %%~nxf
    echo Processing: %%~nxf >> "%logfile%"

    ffmpeg -y -hide_banner -i "%%~f" ^
        -c:a libmp3lame -b:a 320k ^
        -map_metadata -1 -write_xing 1 -id3v2_version 3 ^
        -metadata TSSE="LAME3.100" ^
        "completed_files\%%~nxf" >> "%logfile%" 2>&1

    if exist "completed_files\%%~nxf" (
        echo ✅ Cleaned: %%~nxf >> "%logfile%"
    ) else (
        echo ❌ Failed: %%~nxf >> "%logfile%"
    )
)

:: -------------------------------
:: Wrap Up
:: -------------------------------
echo.
echo ✅ All done! Cleaned MP3s saved to completed_files\
echo Log saved to: %logfile%
pause
endlocal
exit /b

