@echo off
title DeepSeek RAG Agent
cd /d "%~dp0"

echo ========================================
echo   Deepseek Local RAG Reasoning Agent
echo ========================================
echo.

echo Checking Ollama...
ollama list >nul 2>&1
if errorlevel 1 (
    echo ERROR: Ollama is not running!
    echo Please start Ollama from the Start Menu first, then run this again.
    pause
    exit /b 1
)
echo Ollama is running

echo.
echo Checking port 8501...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8501.*LISTENING" 2^>nul') do (
    echo Stopping old Streamlit process...
    taskkill /f /pid %%a >nul 2>&1
)

echo Starting Streamlit...
call .\venv\Scripts\activate.bat

start http://localhost:8501
streamlit run deepseek_rag_agent.py --server.port 8501
pause
