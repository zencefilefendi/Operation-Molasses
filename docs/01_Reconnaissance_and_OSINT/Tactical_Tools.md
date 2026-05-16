# 🛠️ Tactical Tools: Automated Reconnaissance

As part of the *Operation Molasses* upgrade, Zencefil Efendi has provided an automated reconnaissance script. We don't just read about Nmap; we execute it seamlessly.

## 🍯 `zencefil-recon.sh`

This script automates the initial phase of the kill-chain by:
1. Pulling `whois` records.
2. Enumerating subdomains via `subfinder`.
3. Running an aggressive `nmap` scan.

### Usage

You can find the script in the `tools/` directory.

```bash
chmod +x zencefil-recon.sh
./zencefil-recon.sh example.com
```

### Script Source

```bash
--8<-- "01_Reconnaissance_and_OSINT/tools/zencefil-recon.sh"
```
