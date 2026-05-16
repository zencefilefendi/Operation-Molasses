# 🪙 Ransomware Simulation

Stealing data is stealthy, but Ransomware is loud. When a Red Team performs a Ransomware Simulation, the goal is not to destroy the network, but to test if the Blue Team's **Endpoint Detection and Response (EDR)** and **SIEM** solutions can detect mass-file encryption behavior.

## 🍯 Zencefil Cryptor (Golang)

In the tools directory, you will find zencefil_cryptor.go. This is a highly concurrent, fully functional encryption tool designed to mimic the exact behavior of modern Ransomware strains like LockBit or Conti, but in a safe, reversible way.

### Features:
- **Golang Concurrency:** Uses Goroutines to encrypt thousands of files simultaneously, stressing the disk I/O to trigger EDR heuristics.
- **AES-256-GCM:** Uses military-grade symmetric encryption.
- **File Renaming:** Appends .zencefil to encrypted files and deletes the originals.
- **Ransom Note:** Drops a READ_ME_ZENCEFIL.txt file in the targeted directory.

### Compilation
Go is statically typed, meaning you can compile it to a standalone .exe that requires no dependencies on the target machine.

```bash
# Compile for Windows (from Linux/Mac)
GOOS=windows GOARCH=amd64 go build -ldflags "-s -w" -o zencefil_cryptor.exe zencefil_cryptor.go
```

### Execution (Red Team Operation)

Drop the executable onto a test machine. **Do not run this on C:\ or C:\Windows!** Target a specific folder filled with dummy documents.

**To Encrypt:**
```cmd
zencefil_cryptor.exe -dir "C:\Users\Public\Documents\TestFolder" -mode encrypt
```
*At this point, you should check your Blue Team's dashboard. Did they catch the mass file modification? Did they block the .exe?*

**To Decrypt (Cleanup):**
```cmd
zencefil_cryptor.exe -dir "C:\Users\Public\Documents\TestFolder" -mode decrypt
```
