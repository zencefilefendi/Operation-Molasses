# 🪓 EDR Killer: Bring Your Own Vulnerable Driver (BYOVD)

When dealing with mature environments, in-memory execution (like our Nim Loader) might not be enough. Advanced Endpoint Detection and Response (EDR) solutions (CrowdStrike, SentinelOne, Defender for Endpoint) use Kernel callbacks to monitor system activity.

You cannot simply open Task Manager and kill an EDR process. They are protected by **Protected Process Light (PPL)**. To kill them, you must become the Kernel.

## 🍯 The BYOVD Attack

To operate at Ring-0 (Kernel Mode), you need a driver. Since 64-bit Windows requires drivers to be digitally signed by Microsoft, attackers cannot just compile and load a malicious driver.

Instead, we **Bring Our Own Vulnerable Driver (BYOVD)**.
We find an old, legitimate driver (like RTCore64.sys from MSI Afterburner or Capcom.sys) that is signed by Microsoft but contains a known vulnerability (e.g., an arbitrary memory read/write flaw).

### The Kill-Chain:
1.  **Drop & Load:** The attacker drops the signed (but vulnerable) .sys file to disk and loads it using the Service Control Manager (Requires standard Administrator privileges).
2.  **Exploit:** The attacker sends specific IOCTL commands to the driver, exploiting its vulnerability to achieve arbitrary Kernel Read/Write primitives.
3.  **Strip PPL:** The attacker reads the Kernel's EPROCESS structures, finds the EDR process, and overwrites the bytes that define its PPL status, effectively stripping its armor.
4.  **Terminate:** The EDR is now just a normal application. The attacker kills it with standard Windows APIs (TerminateProcess).

## 🛠️ Zencefil EDR Killer (Concept)

In the tools directory, you will find a C++ concept code.
This demonstrates the architecture of how you communicate with a vulnerable driver to strip PPL and terminate processes.

*Warning: Kernel manipulation is inherently unstable. An incorrect memory offset will result in an immediate Blue Screen of Death (BSOD).*

### Source Code Reference

```cpp
--8<-- "05_Defense_Evasion_and_Engineering/tools/Zencefil_EDR_Killer/zencefil_edr_killer.cpp"
```
