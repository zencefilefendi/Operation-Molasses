# 🔌 Physical Infiltration & Hardware Hacking

When external perimeters are impenetrable, zero-trust is enforced, and spear-phishing fails, the final frontier is physical access. State-sponsored actors understand that if you can touch the hardware, the software is already compromised.

## 🍯 BadUSB & Rubber Ducky Payloads

In the BadUSB_Payloads directory, you will find custom **DuckyScripts** crafted by Zencefil Efendi.

### What is BadUSB?
A BadUSB device (like the Hak5 Rubber Ducky, MalDuino, or a flashed Digispark) looks like a standard USB flash drive but identifies itself to the host computer as a **Human Interface Device (HID) - a keyboard**.

Operating systems inherently trust keyboards. When plugged in, the BadUSB executes pre-programmed keystrokes at superhuman speeds (up to 1000 WPM), typing out malicious commands before the user even realizes what is happening.

### The Zencefil Airgap Bypass Payload
The zencefil_airgap_bypass.txt script demonstrates how to chain physical access with our advanced logical tools:

1. **GUI + R:** Opens the Windows Run dialog.
2. **Hidden Execution:** Types a command to open PowerShell completely hidden from the user's screen (-WindowStyle Hidden).
3. **Download & Execute:** Bypasses local execution policies (-Exec Bypass), reaches out to your C2 server, downloads the zencefil_runner.exe (The Nim In-Memory Loader from Phase 9), and executes it.

**Execution Time:** ~1.5 seconds.
**Result:** Total system compromise bypassing EDRs, initiated purely via physical contact.

### Compiling DuckyScript
To use these scripts, you must compile the plain text files into inject.bin files using the Hak5 Ducky Encoder or a web-based encoder, and then place the .bin file on the root of your BadUSB device's MicroSD card.
