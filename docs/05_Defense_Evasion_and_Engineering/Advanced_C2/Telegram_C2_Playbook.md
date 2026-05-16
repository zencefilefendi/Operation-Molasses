# 📱 Decentralized C2: The Telegram Agent

Traditional Command and Control (C2) frameworks like Cobalt Strike, Sliver, or Metasploit rely on direct beaconing to attacker-controlled infrastructure (IPs or Domains). Modern Enterprise Firewalls (NGFW) and EDRs easily detect and block this traffic using Threat Intelligence feeds and Deep Packet Inspection (DPI).

**The Solution:** Blend in with legitimate noise.

Instead of connecting to an evil server, the **Zencefil Telegram C2 Agent** uses the official Telegram Bot API (api.telegram.org) for communication. When the Blue Team inspects the network traffic, all they see is standard HTTPS traffic to Telegram—an application used by millions of legitimate users and businesses.

## 🚀 How to Setup Your Telegram C2

### Step 1: Create the Bot
1. Open Telegram and search for BotFather.
2. Send the command /newbot.
3. Give it a name (e.g., UpdateServiceBot) and a username (e.g., UpdateSvc2026_bot).
4. BotFather will provide you with an **HTTP API Token**. Save this.

### Step 2: Get Your Chat ID
To ensure no one else can control your bot (even if they find your bot's username), the agent hardcodes your personal Chat ID.
1. Search for userinfobot in Telegram and start it.
2. It will reply with your Id (a string of numbers). Save this.

### Step 3: Configure the Agent
Open the agent script and update the configuration variables with the Token and Chat ID you just obtained.

```python
# --- CONFIGURATION ---
BOT_TOKEN = "123456789:ABCdefGHIjklmnoPQRstuvwxyz"
CHAT_ID = "987654321"
# ---------------------
```

### Step 4: Execute on Target
Drop and execute the script on the compromised machine. 
As soon as it runs, your Telegram app will receive a notification:

```
🍯 Zencefil Agent Online
Host: WIN-SRV-2019
OS: Windows
User: Administrator
Awaiting commands...
```

### Step 5: Command & Control
Simply type operating system commands directly into the Telegram chat:
* You type: whoami /priv
* The bot executes it on the target and replies with the terminal output.
* You type: /selfdestruct
* The bot kills its own process and removes its footprint.

### 📜 Source Code

```python
--8<-- "05_Defense_Evasion_and_Engineering/Advanced_C2/tools/zencefil_telegram_c2.py"
```
