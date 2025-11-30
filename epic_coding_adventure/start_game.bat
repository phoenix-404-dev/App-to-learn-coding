@echo off
echo ===================================================
echo      EPIC CODING ADVENTURE - DEV LAUNCHER
echo ===================================================
echo.
echo [1/2] Starting Backend Server (FastAPI)...
start "Epic Backend" cmd /k "cd backend && uvicorn main:app --reload --port 8000"

echo.
echo [2/2] Launching Frontend (Flutter Web)...
echo Please wait for Chrome to open...
cd frontend
flutter run -d chrome
