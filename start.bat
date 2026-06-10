@echo off
title DeepSeek RAG Agent
cd /d "%~dp0"

echo ========================================
echo   Deepseek Local RAG Reasoning Agent
echo ========================================
echo.

echo Checking Ollama...
tasklist /fi "ImageName eq ollama.exe" 2^>nul ^| find /i "ollama.exe" >nul
if errorlevel 1 (
    echo Starting Ollama in background...
    start /b "" "%LOCALAPPDATA%\Programs\Ollama\ollama.exe"
    timeout /t 8 /nobreak >nul
) else (
    echo Ollama is running
)

echo Starting Streamlit...
call .\venv\Scripts\activate.bat

start http://localhost:8501
streamlit run deepseek_rag_agent.py --server.port 8501
pause
