#!/usr/bin/env python3
# ==============================================================================
# 🍯 Zencefil Efendi's AI Target Profiler (Concept)
# Description: Automates the processing of raw OSINT data to identify 
#              High-Value Targets (HVTs) and generate spear-phishing contexts.
# Note: In a live APT environment, this connects to a local LLM or NLP backend.
# ==============================================================================

import json
import argparse
import random

def load_osint_data(filepath):
    try:
        with open(filepath, 'r') as f:
            return json.load(f)
    except Exception as e:
        print(f"[!] Failed to read OSINT data: {e}")
        return []

def profile_target(employee):
    score = 0
    tags = []
    
    # Keyword analysis for High-Value Targeting
    hvt_keywords = ["admin", "devops", "cloud", "security", "sysadmin", "infrastructure", "director", "c-level"]
    finance_keywords = ["finance", "payroll", "accounting", "billing"]
    
    title = employee.get('title', '').lower()
    department = employee.get('department', '').lower()
    
    if any(kw in title or kw in department for kw in hvt_keywords):
        score += 80
        tags.append("IT_PRIVILEGED")
    
    if any(kw in title or kw in department for kw in finance_keywords):
        score += 60
        tags.append("FINANCE_ACCESS")
        
    if "new" in title or "intern" in title:
        score += 40
        tags.append("VULNERABLE_NEW_HIRE")

    return {"score": score, "tags": tags}

def generate_phishing_context(tags):
    contexts = []
    if "IT_PRIVILEGED" in tags:
        contexts.append("Urgent: AWS IAM Policy Rotation Required")
        contexts.append("Action Required: VPN Certificate Expiry")
    if "FINANCE_ACCESS" in tags:
        contexts.append("Invoice Pending: Q3 Vendor Payments")
        contexts.append("Confidential: Updated Payroll Structure")
    if "VULNERABLE_NEW_HIRE" in tags:
        contexts.append("Welcome! Required IT Onboarding Document")
        
    if not contexts:
        contexts.append("Annual Company Policy Update")
        
    return random.choice(contexts)

def main():
    print("==================================================")
    print("🍯 Zencefil AI Target Profiler")
    print("==================================================")
    
    parser = argparse.ArgumentParser(description="Analyze OSINT data to find High Value Targets.")
    parser.add_argument("-i", "--input", required=True, help="JSON file containing scraped employee OSINT data")
    args = parser.parse_args()

    data = load_osint_data(args.input)
    if not data:
        return

    print(f"[*] Processing {len(data)} employee records...")
    
    hvts = []
    for emp in data:
        profile = profile_target(emp)
        if profile['score'] >= 60:
            context = generate_phishing_context(profile['tags'])
            hvts.append({
                "name": emp.get('name', 'Unknown'),
                "email": emp.get('email', 'Unknown'),
                "score": profile['score'],
                "tags": profile['tags'],
                "phish_context": context
            })

    # Sort by highest score
    hvts.sort(key=lambda x: x['score'], reverse=True)

    print("\n[+] High-Value Targets Identified:\n")
    for target in hvts:
        print(f"🎯 Target: {target['name']} ({target['email']})")
        print(f"   Score:  {target['score']}")
        print(f"   Tags:   {', '.join(target['tags'])}")
        print(f"   Phish:  Subject: '{target['phish_context']}'\n")
        
    print(f"[*] Profiling complete. Feed these targets into the Zencefil Phishing Node.")

if __name__ == "__main__":
    main()
