# DeepSeek Local RAG Reasoning Agent

A powerful reasoning agent that combines local DeepSeek models with RAG capabilities — all running on your machine.

Built with **DeepSeek R1** (via Ollama), **Snowflake Arctic Embed** for embeddings, **Qdrant** for vector storage, and **Agno** for agent orchestration.

## Features

- **Dual modes**: simple local chat + RAG-enhanced with document/web context
- **PDF & URL ingestion**: upload PDFs or paste URLs, auto-chunked and embedded
- **Hybrid search**: document retrieval with automatic fallback to web search (Exa AI)
- **Thinking visualization**: see DeepSeek R1's reasoning process
- **Fully local**: LLM + embeddings run on Ollama, no data leaves your machine

## Prerequisites

### 1. Install Ollama

Download from [ollama.com](https://ollama.com) and install.

### 2. Pull models

```bash
ollama pull deepseek-r1:1.5b     # 1.1 GB
ollama pull snowflake-arctic-embed  # 669 MB
ollama pull llama3.2             # 2.0 GB (optional, web search agent)
```

### 3. Qdrant Cloud (free tier)

1. Sign up at [cloud.qdrant.io](https://cloud.qdrant.io)
2. Create a free cluster
3. Copy your **API Key** and **Cluster Endpoint URL**

### 4. Exa AI (optional, for web search fallback)

Sign up at [exa.ai](https://exa.ai) if you want web search capability.

## Quick Start

```bash
# Clone and enter
cd deepseek_local_rag_agent

# Create virtual environment
python -m venv venv
venv\Scripts\activate    # Windows
# source venv/bin/activate  # macOS/Linux

# Install dependencies
pip install -r requirements.txt

# Launch
streamlit run deepseek_rag_agent.py
```

Or **double-click `start.bat`** (Windows only).

Then open [http://localhost:8501](http://localhost:8501).

## Usage

1. Enter your Qdrant API Key and URL in the sidebar
2. Toggle **Enable RAG Mode** ON
3. Upload a PDF or paste a URL
4. Ask questions — the agent retrieves relevant chunks and answers

For simple chat without documents, toggle RAG Mode OFF.

## Tech Stack

| Layer | Technology |
|---|---|
| LLM | DeepSeek R1 (Ollama) |
| Embeddings | Snowflake Arctic Embed (Ollama) |
| Web Search Agent | Llama 3.2 (Ollama) |
| Orchestration | Agno |
| Vector DB | Qdrant Cloud |
| Document Loading | LangChain (PyPDF, WebBaseLoader) |
| UI | Streamlit |

## License

MIT
