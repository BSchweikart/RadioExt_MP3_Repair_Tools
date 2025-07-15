@echo off
echo.
echo =============================================
echo  RadioExt MP3 Fixer (Decode → Clean Rebuild)
echo     Converts MP3s → WAV → MP3 (LAME)
echo =============================================

set INPUT=mp3s_to_fix
set OUTPUT=mp3s_cleaned

if not exist "%INPUT%" (
    echo ❌ Input folder "%INPUT%" does not exist.
    pause
    exit /b
)

if not exist "%OUTPUT%" (
    mkdir "%OUTPUT%"
)

REM Rebuild all MP3s cleanly
for %%F in ("%INPUT%\*.mp3") do (
    echo 🔧 Rebuilding: %%~nxF
    ffmpeg -hide_banner -loglevel error -i "%%F" -ar 44100 -ac 2 -f wav - | lame -b 320 - "%OUTPUT%\%%~nxF"
)

echo.
echo ✅ All MP3s have been rebuilt and saved to '%OUTPUT%'
pause
