#!/bin/bash

# ============================================================
# DarkForge AI Terminal - Install Script
# ============================================================
# هذا السكريبت ينصب Ollama ويسحب النماذج المطلوبة
# شغله على السيرفر حقك عشان تشغل DarkForge AI
# ============================================================

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

banner() {
    echo -e "${CYAN}"
    echo '  ____             _   ______           '  
    echo ' |  _ \  __ _ _ __| |_|  ___|__  _ __  '
    echo ' | | | |/ _` | "__| __| |_ / _ \| "__| '
    echo ' | |_| | (_| | |  | |_|  _| (_) | |    '
    echo ' |____/ \__,_|_|   \__|_|  \___/|_|    '
    echo -e "${NC}"
    echo -e "${YELLOW}☠️  DarkForge AI Terminal - Installer${NC}"
    echo ""
}

banner

# --- تحقق من النظام ---
echo -e "${CYAN}[*] Checking system...${NC}"
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "    OS: $OS"
echo "    Arch: $ARCH"

# --- نصب Ollama ---
echo -e "\n${CYAN}[*] Installing Ollama...${NC}"
if command -v ollama &> /dev/null; then
    echo -e "    ${GREEN}✓ Ollama already installed${NC}"
else
    curl -fsSL https://ollama.com/install.sh | sh
    echo -e "    ${GREEN}✓ Ollama installed successfully${NC}"
fi

# --- تشغيل خدمة Ollama ---
echo -e "\n${CYAN}[*] Starting Ollama service...${NC}"
ollama serve &
sleep 3
echo -e "    ${GREEN}✓ Ollama service running${NC}"

# --- سحب النماذج ---
echo -e "\n${CYAN}[*] Pulling AI models...${NC}"

MODELS=(
    "llama3.2:1b"
    "mistral:7b"
    "codellama:7b"
)

for model in "${MODELS[@]}"; do
    echo -e "\n${YELLOW}[+] Pulling $model...${NC}"
    ollama pull "$model"
    echo -e "    ${GREEN}✓ $model ready${NC}"
done

# --- رسالة النهاية ---
echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}  DarkForge AI Terminal جاهز للاستخدام!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e ""
echo -e "  شغل الأمر عشان تبدأ:"
echo -e "  ${CYAN}ollama run llama3.2:1b${NC}"
echo -e ""
echo -e "  أو شغل السيرفر عشان تتصفح من الموقع:"
echo -e "  ${CYAN}ollama serve${NC}"
echo -e ""
