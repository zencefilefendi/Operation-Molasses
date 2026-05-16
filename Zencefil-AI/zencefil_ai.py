#!/usr/bin/env python3
# ==============================================================================
# 🧠 Zencefil-AI: Autonomous Red Team Agent
# Description: Acts as an autonomous penetration testing brain. It reads the 
#              Operation Molasses methodology (Markdown files), executes recon, 
#              evaluates findings, and proposes/executes attack vectors.
# ==============================================================================

import argparse
import sys
import time
from core.engine import ZencefilEngine
from core.ui import print_banner, print_info, print_success, print_warning

def main():
    print_banner()
    parser = argparse.ArgumentParser(description="Zencefil-AI: Autonomous Pentesting Agent")
    parser.add_argument("-t", "--target", required=True, help="Target IP or Domain (e.g., 10.10.10.5 or example.com)")
    parser.add_argument("-m", "--mode", choices=['recon', 'attack', 'full'], default='recon', help="Operation mode (default: recon)")
    parser.add_argument("--auto", action="store_true", help="Auto-approve all actions (DANGEROUS)")
    
    args = parser.parse_args()

    engine = ZencefilEngine(target=args.target, auto_approve=args.auto)

    print_info(f"Initializing Neural Cortex for target: {args.target}")
    time.sleep(1)
    
    if args.mode in ['recon', 'full']:
        engine.run_reconnaissance()
        
    if args.mode in ['attack', 'full']:
        engine.plan_and_execute_attacks()
        
    print_success("Operation Terminated. Zencefil-AI returning to sleep.")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n[!] Emergency Stop Activated. Aborting.")
        sys.exit(1)
