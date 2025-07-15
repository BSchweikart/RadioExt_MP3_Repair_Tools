@echo off
setlocal enabledelayedexpansion

echo.
echo =============================================
echo  RadioExt songInfos.json Generator (Ceiling)
echo =============================================

REM Ask the user for their radio station name
set /p STATION=Enter your radio station folder name (e.g. Anarchist Radio):
echo Processing songs
echo Creating the file
echo Please wait.....

set INPUT=mp3s_to_fix
set OUTPUT=json_file_complete

if not exist "%OUTPUT%" mkdir "%OUTPUT%"

set "firstLine=true"

powershell -NoProfile -Command ^
  "$station = '%STATION%';" ^
  "$files = Get-ChildItem 'mp3s_to_fix' -Filter '*.mp3';" ^
  "$lines = @();" ^
  "foreach ($file in $files) {" ^
  "  $path = $file.FullName;" ^
  "  $duration = & '.\\ffprobe.exe' -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $path;" ^
  "  if ($duration -match '^[0-9\\.]+$') {" ^
  "    $rounded = [math]::Ceiling([double]$duration);" ^
  "    $key = '\"' + $station + '\\' + $file.Name + '\"';" ^
  "    $lines += '    ' + $key + ': ' + $rounded;" ^
  "  }" ^
  "}" ^
  "$last = $lines.Count - 1;" ^
  "for ($i = 0; $i -lt $lines.Count; $i++) {" ^
  "  if ($i -ne $last) { $lines[$i] += ',' }" ^
  "}" ^
  "'{' | Set-Content 'json_file_complete\\songInfos.json';" ^
  "$lines | Add-Content 'json_file_complete\\songInfos.json';" ^
  "'}' | Add-Content 'json_file_complete\\songInfos.json';"

echo.
echo Done! songInfos.json created with station name '%STATION%' in '%OUTPUT%' folder.
pause
