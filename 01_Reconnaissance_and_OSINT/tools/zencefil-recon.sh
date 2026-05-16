#!/bin/bash
# ==============================================================================
# 🍯 Zencefil Efendi's Automated Reconnaissance Script (Operation Molasses)
# ==============================================================================
# Usage: ./zencefil-recon.sh <target-domain>
# Note: Ensure nmap, whois, and subfinder are installed.

TARGET=$1

if [ -z "$TARGET" ]; then
    echo "[!] Error: No target specified."
    echo "Usage: ./zencefil-recon.sh example.com"
    exit 1
fi

echo "=================================================="
echo "🕵️  Starting Operation Molasses Recon on: $TARGET"
echo "=================================================="

mkdir -p "recon_$TARGET"

echo "[+] 1. Extracting WHOIS data..."
whois $TARGET > "recon_$TARGET/whois.txt" 2>/dev/null
echo "    -> Saved to recon_$TARGET/whois.txt"

echo "[+] 2. Enumerating Subdomains (Subfinder)..."
if command -v subfinder &> /dev/null; then
    subfinder -d $TARGET -o "recon_$TARGET/subdomains.txt" -silent
    echo "    -> Saved to recon_$TARGET/subdomains.txt"
else
    echo "    [!] Subfinder not installed. Skipping."
fi

echo "[+] 3. Running aggressive NMAP scan on target..."
nmap -T4 -A -v $TARGET -oN "recon_$TARGET/nmap_scan.txt" > /dev/null 2>&1
echo "    -> Saved to recon_$TARGET/nmap_scan.txt"

echo "=================================================="
echo "🍯 Recon completed. Zencefil Efendi is pleased."
echo "Results saved in directory: recon_$TARGET/"
echo "=================================================="
