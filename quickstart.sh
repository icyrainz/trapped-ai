#!/usr/bin/env bash
set -e

OLLAMA_HOST="${OLLAMA_HOST:-http://akio-ollama:11434}"
OLLAMA_MODEL="${OLLAMA_MODEL:-qwen3:8b}"
PORT="${PORT:-3000}"

# Load .env if present
if [ -f .env ]; then
    export $(grep -v '^#' .env | grep '=' | xargs)
    OLLAMA_HOST="${OLLAMA_HOST:-http://akio-ollama:11434}"
    OLLAMA_MODEL="${OLLAMA_MODEL:-qwen3:8b}"
    PORT="${PORT:-3000}"
fi

echo "=== Trapped AI Quickstart ==="
echo ""

# Check node
if ! command -v node &>/dev/null; then
    echo "ERROR: Node.js not found. Install it first."
    exit 1
fi
echo "[ok] Node.js $(node -v)"

# Install deps if needed
if [ ! -d node_modules ]; then
    echo "[..] Installing dependencies..."
    npm install
else
    echo "[ok] Dependencies installed"
fi

# Check Ollama connectivity
echo "[..] Checking Ollama at $OLLAMA_HOST..."
if curl -sf "$OLLAMA_HOST/api/tags" >/dev/null 2>&1; then
    # Check if model is available
    if curl -sf "$OLLAMA_HOST/api/tags" | grep -q "$OLLAMA_MODEL"; then
        echo "[ok] Ollama reachable, model '$OLLAMA_MODEL' available"
    else
        echo "[!!] Ollama reachable but model '$OLLAMA_MODEL' not found"
        echo "     Run: ollama pull $OLLAMA_MODEL"
        echo "     Starting anyway (will use fallback thoughts)..."
    fi
else
    echo "[!!] Cannot reach Ollama at $OLLAMA_HOST"
    echo "     Starting anyway (will use fallback thoughts)..."
fi

echo ""
echo "Starting server on http://localhost:$PORT"
echo "Press Ctrl+C to stop"
echo ""

node server.js
