import os
import subprocess
from core.ui import print_info, print_success, print_warning, print_error, prompt_user

class ZencefilEngine:
    def __init__(self, target, auto_approve=False):
        self.target = target
        self.auto_approve = auto_approve
        self.memory = {}
        # Path to the knowledge base
        self.kb_path = os.path.join(os.path.dirname(__file__), '../../docs')

    def run_reconnaissance(self):
        print_info(f"Phase 1: Reconnaissance on {self.target}")
        
        # Simulating loading knowledge from docs
        print_info("Accessing Zencefil Knowledge Base (docs/01_Reconnaissance_and_OSINT)...")
        recon_script = os.path.join(self.kb_path, '01_Reconnaissance_and_OSINT/tools/zencefil-recon.sh')
        
        if not os.path.exists(recon_script):
            print_error(f"Recon script not found at {recon_script}")
            return

        if not self.auto_approve:
            if not prompt_user(f"Execute Nmap & Subfinder pipeline against {self.target}?"):
                print_warning("Reconnaissance skipped by user.")
                return

        print_info(f"Executing: {recon_script} -d {self.target} -s")
        # In a real scenario we use subprocess.run, but here we just simulate for safety
        try:
            # Create a mock output for the lab environment
            self.memory['open_ports'] = [80, 8080, 22]
            self.memory['technologies'] = ['PHP', 'MySQL', 'Docker']
            print_success(f"Recon complete. Identified open ports: {self.memory['open_ports']}")
            print_success(f"Identified technologies: {self.memory['technologies']}")
        except Exception as e:
            print_error(f"Recon failed: {e}")

    def plan_and_execute_attacks(self):
        print_info(f"Phase 2: Tactical Analysis & Attack Planning")
        
        if not self.memory.get('open_ports'):
            print_warning("No recon data found. Run with --mode recon first or use --mode full.")
            return

        print_info("Consulting MITRE ATT&CK mappings in Knowledge Base...")
        
        # Simple AI Decision Tree based on Recon Memory
        if 8080 in self.memory['open_ports'] and 'PHP' in self.memory['technologies']:
            print_success("Match found: Web Application Vulnerability Lab detected (Port 8080).")
            self._execute_web_attack()
            
        elif 502 in self.memory['open_ports']:
            print_success("Match found: Modbus/SCADA target detected.")
            self._execute_scada_attack()
            
        else:
            print_warning("No automated attack playbooks match the current target profile.")

    def _execute_web_attack(self):
        print_info("Loading SSRF Playbook from docs/02_Initial_Access_and_Exploitation...")
        if not self.auto_approve:
            if not prompt_user("Initiate automated SSRF and SQLi probing on Port 8080?"):
                print_warning("Attack aborted by operator.")
                return
        
        print_info("Injecting payloads into target parameters...")
        print_success("Payload execution successful! Reverse shell established (Simulated).")
        print_info("Transitioning to Phase 3: Privilege Escalation (Pending Module Update).")

    def _execute_scada_attack(self):
        # Placeholder for SCADA attack logic
        pass
