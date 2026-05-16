# UI Helper functions for Zencefil-AI

def print_banner():
    banner = """
   🍯===============================================🍯
       ___                  __ _ __         _   ___ 
      / _ \___ _ __  ___   / _(_) /        /_\ |_ _|
     / /_)/ _ \ '_ \/ -_) |  _| | |  ___  //_\\\ | | 
    / ___/\___/ .__/\___| |_| |_|_| |___|/  _  \| | 
    \/        |_|                        \_/ \_/___|
                                                    
    [ AUTONOMOUS RED TEAM AGENT - STATE-ACTOR LEVEL ]
   🍯===============================================🍯
    """
    print(f"\033[93m{banner}\033[0m") # Yellow

def print_info(msg):
    print(f"\033[94m[*]\033[0m {msg}") # Blue

def print_success(msg):
    print(f"\033[92m[+]\033[0m {msg}") # Green

def print_warning(msg):
    print(f"\033[93m[-]\033[0m {msg}") # Yellow

def print_error(msg):
    print(f"\033[91m[!]\033[0m {msg}") # Red

def prompt_user(msg):
    return input(f"\033[95m[?]\033[0m {msg} [Y/n]: ").strip().lower() != 'n'
