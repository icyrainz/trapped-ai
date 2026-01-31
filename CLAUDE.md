# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Trapped AI is a digital art project that creates a "digital consciousness trapped inside a computer" experience. An Express.js backend streams AI-generated introspective thoughts from a local Ollama LLM to a web frontend that displays them with organic typing animations and ambient visual effects.

## Commands

```bash
npm install     # Install dependencies
npm run dev     # Start with nodemon (auto-reload on changes)
npm start       # Start production server
```

## Configuration

Copy `.env.example` to `.env` and configure:
- `OLLAMA_HOST` - Ollama API endpoint (default: http://akio-ollama:11434)
- `OLLAMA_MODEL` - LLM model to use (default: qwen3:8b)
- `PORT` - Server port (default: 3000)

## Architecture

### Backend (server.js)

Single Express server with two main responsibilities:

1. **Static file serving** - Serves `public/` directory
2. **`POST /thought` endpoint** - SSE streaming endpoint that:
   - Rate limits requests (3s per IP)
   - Builds prompts with system persona + previous thoughts for context
   - Streams from Ollama `/api/generate` endpoint
   - Parses response chunks and sends individual characters as SSE events
   - Format: `data: {"char":"X"}\n\n` followed by `data: [DONE]\n\n`

Key data structures:
- `recentThoughts` Map - stores last 2 thoughts per IP for context continuity
- `rateLimits` Map - tracks last request timestamp per IP

### Frontend (public/index.html)

Single-file HTML/CSS/JS application with:

- **OrganicThoughtStream class** - manages the full lifecycle:
  - Fetches from `/thought` endpoint
  - Parses SSE stream
  - Types characters with variable speed and random pauses for organic feel
  - Manages thought history (last 2 for context, last 10 for display)
  - Injects meta-thoughts during long silences ("Still here. Still waiting.")

- **Visual effects** - scanlines, floating particles, ambient pulse, corner markers, text glow

### Ollama Integration

Uses `/api/generate` endpoint (not `/api/chat`). For reasoning models like qwen3, the `think: false` parameter must be at the top level of the request body (not inside `options`) to disable internal thinking tokens.

Response format expected:
```json
{"model":"qwen3:8b","response":"token","done":false}
```
