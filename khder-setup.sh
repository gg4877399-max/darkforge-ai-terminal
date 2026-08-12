#!/bin/bash
# KHder Server Setup - UnCensored AI + Hacking Env
# Server: khder | RAM: 32GB

GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; PURPLE='\033[0;35m'; NC='\033[0m'

# Banner
echo -e "${PURPLE}"
echo ' _  __          _              '
echo '| |/ /__ _ _ __| |_ ___ _ __  '
echo '| " / _` | "__| __/ _ \ "__| '
echo '| . \ (_| | |  | ||  __/ |    '
echo '|_|\_\__,_|_|   \__\___|_|    '
echo -e "${NC}"
echo -e "${YELLOW}Server: khder | RAM: 32GB | UnCensored AI + Hacking Env${NC}"

# Update system
echo -e "${CYAN}[*] Updating system...${NC}"
sudo apt-get update -y && sudo apt-get upgrade -y

# Install tools
echo -e "${CYAN}[*] Installing tools...${NC}"
sudo apt-get install -y curl wget git python3 python3-pip nmap hydra john hashcat sqlmap nikto gobuster ffuf metasploit-framework aircrack-ng proxychains4 tor htop tmux vim jq

# Python tools
pip3 install requests scapy paramiko impacket cryptography dnspython colorama tqdm

# Install Ollama
echo -e "${CYAN}[*] Installing Ollama...${NC}"
curl -fsSL https://ollama.com/install.sh | sh
ollama serve &
sleep 5

# Pull uncensored models (32GB RAM)
echo -e "${CYAN}[*] Pulling uncensored AI models...${NC}"
for model in dolphin-mixtral:8x7b dolphin-llama3:70b wizard-vicuna:13b codellama:34b llama3:8b qwen2.5-coder:14b; do
    echo -e "${YELLOW}[+] Pulling $model...${NC}"
    ollama pull "$model" 2>/dev/null || echo "Failed: $model"
done

# Create AI chat script
cat > /usr/local/bin/khder-ai << 'EOFM'
#!/bin/bash
echo -e "\033[0;35m☠️  KHder UnCensored AI\033[0m"
echo "1) Dolphin 8x7B (UnCensored)"
echo "2) Wizard 13B (UnCensored)"
echo "3) CodeLlama 34B"
echo "4) Llama3 8B"
echo "5) Qwen 14B"
read -p "Select [1-5]: " c
case $c in 1) M="dolphin-mixtral:8x7b";; 2) M="wizard-vicuna:13b";; 3) M="codellama:34b";; 4) M="llama3:8b";; 5) M="qwen2.5-coder:14b";; *) M="dolphin-mixtral:8x7b";; esac
echo -e "\033[0;32mModel: $M\033[0m"
while true; do
    echo -ne "\033[0;36mkhder@ai> \033[0m"
    read p; [ "$p" = "exit" ] && break; [ -z "$p" ] && continue
    ollama run "$M" "$p"
done
EOFM
chmod +x /usr/local/bin/khder-ai

# Create hacking menu
cat > /usr/local/bin/khder-hack << 'EOFH'
#!/bin/bash
echo -e "\033[0;31m☠️  KHder Hacking Environment\033[0m"
echo "1) Nmap 2) Nikto 3) SQLMap 4) Hydra 5) John 6) Hashcat 7) Metasploit 8) Gobuster 9) Ffuf 0) Exit"
read -p "Select: " t
case $t in
    1) read -p "Target: " x; nmap -sV -sC -O "$x";;
    2) read -p "URL: " x; nikto -h "$x";;
    3) read -p "URL: " x; sqlmap -u "$x" --batch --risk=3 --level=5;;
    4) echo "hydra -l admin -P /usr/share/wordlists/rockyou.txt TARGET ssh";;
    5) read -p "Hash file: " x; john "$x";;
    6) echo "hashcat -m 0 -a 0 hash.txt rockyou.txt";;
    7) echo "msfconsole";;
    8) read -p "URL: " x; gobuster dir -u "$x" -w /usr/share/wordlists/dirb/common.txt;;
    9) read -p "URL: " x; ffuf -u "$x/FUZZ" -w /usr/share/wordlists/dirb/common.txt;;
    0) exit;;
esac
EOFH
chmod +x /usr/local/bin/khder-hack

# Ollama service
echo -e "${CYAN}[*] Creating systemd service...${NC}"
cat > /etc/systemd/system/ollama.service << 'EOFS'
[Unit]
Description=Ollama
After=network.target
[Service]
ExecStart=/usr/local/bin/ollama serve
Restart=always
Environment=OLLAMA_HOST=0.0.0.0:11434
[Install]
WantedBy=multi-user.target
EOFS
systemctl daemon-reload && systemctl enable ollama && systemctl restart ollama

# Wordlists
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then gunzip -f /usr/share/wordlists/rockyou.txt.gz; fi

# Done
echo -e "${GREEN}KHder Server Ready!${NC}"
echo -e "${CYAN}Commands: khder-ai (AI chat) | khder-hack (hacking tools)${NC}"
echo -e "${YELLOW}Server: khder | RAM: 32GB${NC}"