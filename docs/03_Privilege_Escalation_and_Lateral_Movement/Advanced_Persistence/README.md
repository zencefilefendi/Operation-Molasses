# 🧟 Advanced Persistence (WMI Hijacking)

Getting `SYSTEM` or `Domain Admin` is only half the battle. If the server reboots and you lose your shell, you have failed the operation.

Amateurs use Scheduled Tasks, the Startup folder, or standard Run Registry keys. These are loud and heavily monitored by EDRs (Endpoint Detection and Response).

Advanced Persistent Threats (APTs) use **Fileless Persistence**, residing entirely in the Windows Registry or WMI repositories.

## 🍯 WMI Event Subscriptions

Windows Management Instrumentation (WMI) allows administrators to create rules: *"If X happens, do Y"*. We abuse this to say: *"If the system boots, execute our Base64 encoded payload in memory."*

### The Zencefil WMI Persistence Script

In the tools directory, you will find a PowerShell script.

This script creates three WMI objects:
1.  **Event Filter:** The trigger. We set this to trigger when the system uptime reaches 5 minutes.
2.  **Event Consumer:** The action. We set this to execute a hidden, Base64-encoded PowerShell command (your reverse shell or beacon).
3.  **FilterToConsumerBinding:** Links the trigger to the action.

### Why is this dangerous?
-   **Fileless:** The malicious command is stored inside the WMI repository, not as an executable on the disk.
-   **Stealth:** It executes as the SYSTEM user via the WmiPrvSE.exe process, which is a legitimate Windows process that often bypasses behavioral analysis.

### Removal (Cleanup)
If you need to remove the persistence (always clean up after an engagement):
```powershell
Get-WmiObject -Namespace root\subscription -Class __EventFilter -Filter "Name='ZencefilBootFilter'" | Remove-WmiObject
Get-WmiObject -Namespace root\subscription -Class CommandLineEventConsumer -Filter "Name='ZencefilPayloadConsumer'" | Remove-WmiObject
Get-WmiObject -Namespace root\subscription -Class __FilterToConsumerBinding | Where-Object {$_.Filter -match 'ZencefilBootFilter'} | Remove-WmiObject
```
