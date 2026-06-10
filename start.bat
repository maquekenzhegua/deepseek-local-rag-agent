@echo off
chcp 65001 >nul
title DeepSeek RAG Agent

echo ========================================
echo   🐋 Deepseek Local RAG Reasoning Agent
echo ========================================
echo.

:: 检查 Ollama 是否在运行
echo [1/3] 检查 Ollama 服务...
ollama list >nul 2>&1
if errorlevel 1 (
    echo Ollama 未启动，正在启动...
    start "" "C:\Users\%USERNAME%\AppData\Local\Programs\Ollama\ollama.exe"
    echo 等待 Ollama 启动...
    timeout /t 5 /nobreak >nul
) else (
    echo Ollama 已运行 ✅
)

:: 激活虚拟环境并启动 Streamlit
echo [2/3] 启动 Streamlit...
cd /d "D:\awesome-llm-apps\rag_tutorials\deepseek_local_rag_agent"
call .\venv\Scripts\activate.bat
start "" http://localhost:8501

echo [3/3] 正在打开浏览器...
echo.
echo 如果浏览器未自动打开，请手动访问: http://localhost:8501
echo 按 Ctrl+C 可以停止服务
echo.

streamlit run deepseek_rag_agent.py --server.port 8501
pause
