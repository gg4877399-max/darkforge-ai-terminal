# DarkForge AI Terminal

Dark AI Assistant with Ollama Integration

## Overview

DarkForge AI Terminal is a web-based AI chat interface powered by Ollama. It features a Matrix-style terminal aesthetic with real-time AI model interaction.

## Features

- Terminal-style UI with Matrix rain background
- Multi-model support: Llama 3.2, Mistral, CodeLlama
- Real-time chat via Ollama API
- Live server status monitoring
- Responsive design
- Quick action buttons

## Quick Install

### 1. Run the install script:

```bash
curl -fsSL https://raw.githubusercontent.com/gg4877399-max/darkforge-ai-terminal/main/install.sh | bash
```

### 2. Or install manually:

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama serve &
ollama pull llama3.2:1b
ollama pull mistral:7b
ollama pull codellama:7b
```

### 3. Serve the website:

```bash
python3 -m http.server 8080 --bind 0.0.0.0
```

### 4. Open in browser:

```
http://YOUR_SERVER_IP:8080
```

## Deploy on GitHub Pages

1. Go to repo Settings > Pages
2. Source: Deploy from branch > main > / (root)
3. Save - site will be live at:
   https://gg4877399-max.github.io/darkforge-ai-terminal/

> Note: Ollama server must be running separately on your VPS.

## Project Structure

```
darkforge-ai-terminal/
├── index.html      # AI Chat Website
├── install.sh      # Auto-install script
└── README.md       # Documentation
```

## Requirements

- Linux VPS (Ubuntu/Debian)
- 4GB+ RAM (for 7B models)
- Python3 or Node.js

---

Built with by gg4877399-max
