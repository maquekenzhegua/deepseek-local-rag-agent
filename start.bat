@echo off
title DeepSeek RAG Agent

:: Go to the folder where this bat file lives (fixes shortcut "Start in" issues)
cd /d "%~dp0"

echo ========================================
echo   Deepseek Local RAG Reasoning Agent
echo ========================================
echo.

:: Check if Ollama is running
echo Checking Ollama...
tasklist /fi "ImageName eq ollama.exe" 2^>nul ^| find /i "ollama.exe" >nul
if errorlevel 1 (
    echo Starting Ollama...
    start "" "%LOCALAPPDATA%\Programs\Ollama\ollama.exe"
    echo Waiting 10 seconds for Ollama...
    timeout /t 10 /nobreak >nul
) else (
    echo Ollama is running
)

:: Activate venv and start
echo.
echo Starting Streamlit...
call .\venv\Scripts\activate.bat

echo.
echo Opening http://localhost:8501 ...
start http://localhost:8501

streamlit run deepseek_rag_agent.py --server.port 8501
pause
