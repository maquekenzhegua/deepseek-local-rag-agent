# 🐋 DeepSeek Local RAG Reasoning Agent

[![License: MIT](https://img.shields.io/badge/License-MIT-white.svg)](https://opensource.org/licenses/MIT)
[![Python 3.11+](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/)
[![Ollama](https://img.shields.io/badge/Ollama-Local-black.svg)](https://ollama.com)

A fully local RAG agent that combines **DeepSeek R1's reasoning** with **document retrieval** — no API keys required for core functionality, everything runs on your machine.

<p align="center">
  <img src="https://img.shields.io/badge/LLM-DeepSeek%20R1-FF6B35" alt="DeepSeek R1">
  <img src="https://img.shields.io/badge/Embeddings-Snowflake%20Arctic-29B6F6" alt="Snowflake Arctic">
  <img src="https://img.shields.io/badge/Vector%20DB-Qdrant-FFC107" alt="Qdrant">
  <img src="https://img.shields.io/badge/Framework-Agno-00C853" alt="Agno">
  <img src="https://img.shields.io/badge/UI-Streamlit-FF4B4B" alt="Streamlit">
</p>

---

## Why this exists

Most RAG tutorials require OpenAI API keys, paid vector DBs, and cloud LLMs. This agent runs **completely on your hardware** — the LLM, embeddings, and reasoning all happen locally through Ollama. The only cloud component is a free-tier Qdrant vector database.

## What it does

| Mode | Description |
|---|---|
| **Chat Mode** | Direct conversation with DeepSeek R1 — reasoning model with visible thinking process |
| **RAG Mode** | Upload PDFs or URLs → auto-chunk → embed → query with source attribution |
| **Hybrid Search** | Document retrieval first, automatic fallback to web search (Exa AI) if nothing relevant found |

## Architecture

```
┌─────────────────────────────────────────────────┐
│                   Streamlit UI                    │
│    (chat input · file upload · config sidebar)   │
└──────────┬───────────────────┬──────────────────┘
           │                   │
     ┌─────▼─────┐      ┌──────▼──────┐
     │  Chat Mode │      │   RAG Mode   │
     │            │      │              │
     │ DeepSeek R1│      │  PDF / URL   │
     │  (Ollama)  │      │      │       │
     └────────────┘      │  Chunking    │
                         │      │       │
                         │  Embedding   │
                         │  (Snowflake) │
                         │      │       │
                         │  Qdrant      │
                         │      │       │
                         │  Retrieve    │
                         │      │       │
                         │  DeepSeek R1 │
                         └──────────────┘
```

## Quick Start

### 1. Prerequisites

- **Python 3.11+**
- **[Ollama](https://ollama.com)** — installed and running (check taskbar for 🐑)

### 2. Pull models

```bash
ollama pull deepseek-r1:1.5b           # 1.1 GB — main reasoning LLM
ollama pull snowflake-arctic-embed      # 669 MB — embeddings model
ollama pull llama3.2                   # 2.0 GB — optional, web search agent
```

### 3. Qdrant Cloud (free)

1. Sign up at [cloud.qdrant.io](https://cloud.qdrant.io)
2. Create a **free tier** cluster (1GB storage included)
3. Wait for cluster to show **Active** (green)
4. Copy your **API Key** from "API Keys" section
5. Copy your **Cluster Endpoint URL** (format: `https://xxx.cloud.qdrant.io`)

### 4. Exa AI (optional)

For web search fallback, sign up at [exa.ai](https://exa.ai) and get an API key.

### 5. Install & Run

```bash
git clone https://github.com/maquekenzhegua/deepseek-local-rag-agent.git
cd deepseek-local-rag-agent

python -m venv venv
venv\Scripts\activate    # Windows
# source venv/bin/activate  # macOS / Linux

pip install -r requirements.txt
streamlit run deepseek_rag_agent.py
```

**Or** on Windows, just double-click `start.bat`.

## Usage

### Chat Mode (no setup needed)

1. Make sure Ollama is running
2. Launch the app
3. Toggle **Enable RAG Mode OFF** in the sidebar
4. Start chatting with DeepSeek R1

### RAG Mode

1. In the sidebar, fill in:
   - **Qdrant API Key** and **Qdrant URL**
   - Optionally **Exa AI API Key** for web search fallback
2. Keep **Enable RAG Mode ON**
3. Upload a PDF or paste a URL
4. Wait for "Documents stored successfully"
5. Ask questions — the agent retrieves relevant chunks and answers with sources

### Tips

- **Model choice**: `deepseek-r1:1.5b` works on most laptops. If you have a strong GPU, `ollama pull deepseek-r1:7b` gives better results.
- **Similarity threshold**: Lower values return more documents (broader but noisier), higher values are more precise.
- **Web search toggle** (🌐): Force web search even if documents exist in the vector store.
- **Clear Chat History**: Resets conversation context but keeps your uploaded documents in Qdrant.

## Tech Stack

| Layer | Technology | Runs |
|---|---|---|
| LLM | DeepSeek R1 (Ollama) | Local |
| Embeddings | Snowflake Arctic Embed (Ollama) | Local |
| Web Search Agent | Llama 3.2 (Ollama) | Local |
| Agent Framework | Agno | Local |
| Document Loading | PyPDF + BeautifulSoup4 + LangChain | Local |
| Vector Database | Qdrant Cloud | Free tier (1GB) |
| Web Search | Exa AI | Optional cloud |
| UI | Streamlit | Local |

## Files

```
deepseek-local-rag-agent/
├── deepseek_rag_agent.py    # Main application
├── requirements.txt          # Python dependencies
├── start.bat                 # One-click launcher (Windows)
└── README.md
```

## Troubleshooting

| Problem | Fix |
|---|---|
| `ModuleNotFoundError: No module named 'xxx'` | Run `pip install -r requirements.txt` again |
| Ollama 502 errors | Make sure Ollama is running (check taskbar icon) |
| Qdrant 502 errors | Cluster may be asleep — wake it in Qdrant Cloud console |
| "input length exceeds context" | Your PDF text is too long per chunk — reduce `chunk_size` in the code |
| Port 8501 in use | Kill the old process or use `streamlit run --server.port 8502` |

## License

MIT — use it, fork it, ship it.
