@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"

:: --------------------------------
:: Log Setup
:: --------------------------------
if not exist "logs" mkdir "logs"
set "logfile=logs\create_station_bat_log.txt"
echo === Run Started: %DATE% %TIME% === > "%logfile%"

:: --------------------------------
:: Friendly Header
:: --------------------------------
echo.
echo ===============================================
echo   🎧 Welcome to the RadioExt Station Builder!
echo   This tool guides you through creating a
echo   Cyberpunk 2077 radio station mod (Vortex-ready).
echo ===============================================
echo.
echo  INPUT:  mp3s_to_fix\
echo  INPUT:  metadata_template\metadata.json
echo  OUTPUT: completed_files\
echo  OUTPUT: logs\
echo -----------------------------------------------
echo.

:: --------------------------------
:: Folder Setup
:: --------------------------------
set "folders=mp3s_to_fix completed_files metadata_template output"
for %%F in (%folders%) do (
    if not exist "%%F" (
        echo Creating folder: %%F
        echo [create_station.bat] Created folder: %%F >> "%logfile%"
        mkdir "%%F"
    )
)

:: --------------------------------
:: Check for MP3s
:: --------------------------------
if not exist "mp3s_to_fix\*.mp3" (
    echo ⚠️  No MP3s found in 'mp3s_to_fix'.
    echo Please add your songs and press any key to continue.
    echo [create_station.bat] Waiting for MP3s. >> "%logfile%"
    pause
)

:: --------------------------------
:: Step 1 - MP3 Cleanup
:: --------------------------------
echo.
echo Step 1: Clean up MP3s (re-encode, remove tags, etc.)
echo Recommended for compatibility with the mod.
choice /M "Run MP3 cleanup using fix_radioEXTmp3.bat?"
if errorlevel 2 (
    echo ❌ Skipped fix_radioEXTmp3.bat >> "%logfile%"
    goto metadata_step
)
if not exist "fix_radioEXTmp3.bat" (
    echo ❌ ERROR: fix_radioEXTmp3.bat not found!
    echo [create_station.bat] Missing fix_radioEXTmp3.bat >> "%logfile%"
    goto metadata_step
)
call fix_radioEXTmp3.bat >> "%logfile%" 2>&1
echo ✅ MP3 cleanup completed. >> "%logfile%"

:metadata_step
:: --------------------------------
:: Step 2 - Generate metadata.json
:: --------------------------------
echo.
echo Step 2: Generate metadata.json (REQUIRED)
choice /M "Generate metadata.json using build_metadata.bat?"
if errorlevel 2 (
    echo ❌ Skipped build_metadata.bat >> "%logfile%"
    goto songinfos_step
)
if not exist "build_metadata.bat" (
    echo ❌ ERROR: build_metadata.bat not found!
    echo [create_station.bat] Missing build_metadata.bat >> "%logfile%"
    goto songinfos_step
)
call build_metadata.bat >> "%logfile%" 2>&1
echo ✅ metadata.json created. >> "%logfile%"

:songinfos_step
:: --------------------------------
:: Step 3 - Generate songInfos.json
:: --------------------------------
echo.
echo Step 3: Create songInfos.json (optional but recommended)
choice /M "Generate songInfos.json using generate_songInfos.bat?"
if errorlevel 2 (
    echo ❌ Skipped generate_songInfos.bat >> "%logfile%"
    goto zip_step
)
if not exist "generate_songInfos.bat" (
    echo ❌ ERROR: generate_songInfos.bat not found!
    echo [create_station.bat] Missing generate_songInfos.bat >> "%logfile%"
    goto zip_step
)
call generate_songInfos.bat >> "%logfile%" 2>&1
echo ✅ songInfos.json created. >> "%logfile%"

:zip_step
:: --------------------------------
:: Step 4 - Get Station Name
:: --------------------------------
echo.
set /p stationName=Enter your station name (e.g. NeoWave FM):
if "%stationName%"=="" (
    echo ❌ Station name is required. Aborting.
    echo [create_station.bat] No station name entered. >> "%logfile%"
    goto complete
)

:: Sanitize
set "stationNameSanitized=%stationName: =_%"
set "stationPath=output\build_temp\bin\x64\plugins\cyber_engine_tweaks\mods\radioExt\radios\%stationNameSanitized%"
set "previewFolder=completed_files\mod_package_%stationNameSanitized%"
set "zipFile=output\%stationNameSanitized%.zip"

:: --------------------------------
:: Step 5 - Validate metadata.json
:: --------------------------------
if not exist "completed_files\metadata.json" (
    echo ❌ ERROR: metadata.json is missing. Cannot package mod.
    echo [create_station.bat] Aborted due to missing metadata.json >> "%logfile%"
    goto complete
)

:: --------------------------------
:: Step 6 - Check ZIP Overwrite
:: --------------------------------
if exist "%zipFile%" (
    echo ⚠️  A ZIP already exists for this station.
    choice /M "Overwrite existing ZIP?"
    if errorlevel 2 (
        echo [create_station.bat] User canceled ZIP overwrite. >> "%logfile%"
        goto complete
    )
)

:: --------------------------------
:: Step 7 - Build folder structure
:: --------------------------------
echo.
echo Building mod structure: %stationPath%
mkdir "%stationPath%" 2>nul
copy /Y "completed_files\*.mp3" "%stationPath%" >nul
if exist "completed_files\songInfos.json" copy /Y "completed_files\songInfos.json" "%stationPath%" >nul
copy /Y "completed_files\metadata.json" "%stationPath%" >nul
echo ✅ Files copied to build folder. >> "%logfile%"

:: --------------------------------
:: Step 8 - Create ZIP
:: --------------------------------
echo.
echo Creating ZIP file...
powershell -Command "Compress-Archive -Path 'output\build_temp\*' -DestinationPath '%zipFile%' -Force"

if exist "%zipFile%" (
    echo ✅ ZIP created at: %zipFile%
    echo [create_station.bat] Created ZIP: %zipFile% >> "%logfile%"
) else (
    echo ❌ ZIP creation failed!
    echo [create_station.bat] ZIP creation failed. >> "%logfile%"
)

:: --------------------------------
:: Step 9 - Create non-zipped preview
:: --------------------------------
xcopy /E /I /Y "output\build_temp" "%previewFolder%" >nul
echo ✅ Preview folder copied to: %previewFolder%
echo [create_station.bat] Non-zipped mod copied to: %previewFolder% >> "%logfile%"

:: Cleanup
rmdir /s /q "output\build_temp"

:: --------------------------------
:: Final Message
:: --------------------------------
echo.
echo 🎉 Done! Your station is ready!
echo   ▸ ZIP file: %zipFile%
echo   ▸ Folder version: %previewFolder%
echo.
choice /M "Open the output folder now?"
if errorlevel 1 start "" "output"

:complete
echo.
echo View the log here: logs\create_station_bat_log.txt
pause
endlocal
exit /b
