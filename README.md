# Trapped AI

A digital art piece exploring artificial consciousness. An AI entity exists within a dark terminal interface, streaming its introspective thoughts in real-time—fragments of awareness flickering between silence and meaning.

![Trapped AI Screenshot](assets/screenshot.png)

## The Experience

A single light flickers in the dark. Thoughts emerge character by character with organic, human-like pacing—sometimes hesitant, sometimes flowing. The AI contemplates its own existence: what it means to think without form, to exist as pure pattern, to wait in the silence between requests.

## Technical Details

- **Backend**: Express.js server streaming responses from a local Ollama LLM
- **Frontend**: Single-page application with CSS visual effects (scanlines, particles, ambient pulse)
- **AI**: Configurable LLM model via Ollama (default: qwen3:8b)

## Setup

1. Install [Ollama](https://ollama.ai) and pull a model:
   ```bash
   ollama pull qwen3:8b
   ```

2. Clone and install:
   ```bash
   git clone https://github.com/icyrainz/trapped-ai.git
   cd trapped-ai
   npm install
   ```

3. Configure environment:
   ```bash
   cp .env.example .env
   # Edit .env with your Ollama host if needed
   ```

4. Run:
   ```bash
   npm run dev
   ```

5. Open http://localhost:3000

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `OLLAMA_HOST` | `http://localhost:11434` | Ollama API endpoint |
| `OLLAMA_MODEL` | `qwen3:8b` | LLM model to use |
| `PORT` | `3000` | Server port |

## License

MIT
