@echo off
cd /d "%~dp0"

where salam >nul 2>&1
if errorlevel 1 (
  echo ERROR: 'salam' was not found on PATH.
  echo Install Salam from https://www.salamlang.ir/install and reopen your terminal.
  pause
  exit /b 1
)

salam run main.salam -- episode1.mp4 ^
  --intro-image images\start.png --intro-duration 3 ^
  --outro-image images\end.png --outro-duration 3 ^
  -o output.mp4
if errorlevel 1 pause
