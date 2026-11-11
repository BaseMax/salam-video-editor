@echo off
cd /d "%~dp0"
salam run main.salam -- episode1.mp4 ^
  --intro-image images\start.png --intro-duration 3 ^
  --outro-image images\end.png --outro-duration 3 ^
  -o output.mp4
if errorlevel 1 pause
