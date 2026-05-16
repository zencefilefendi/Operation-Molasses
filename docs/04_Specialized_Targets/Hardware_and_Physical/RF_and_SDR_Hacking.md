# 📡 Radio Frequency (RF) & SDR Hacking

The physical perimeter of a target does not stop at their front door; it extends into the electromagnetic spectrum around their building. Wireless keyboards, security badges, VIP vehicle key fobs, drone communications, and satellite uplinks all broadcast data through the air.

Advanced threat actors use **Software Defined Radio (SDR)** to intercept, analyze, and manipulate these invisible signals.

## 🍯 The Zencefil SDR Playbook

To execute the attacks below, you need an SDR device. 
* **Listen-Only:** RTL-SDR (Cheap, good for reconnaissance).
* **Transmit & Receive:** HackRF One or BladeRF (Required for active exploitation).

### 1. Replay Attacks (Sub-1 GHz)
Many older physical security systems (parking barriers, old garage doors, wireless doorbells) use unencrypted, static RF signals (usually around 433 MHz or 315 MHz).

**The Attack:**
You sit in the parking lot and record the signal when the CEO opens the barrier. Later, you replay the exact same signal to open the barrier yourself.

**Execution (using Universal Radio Hacker - URH):**
1. Open URH and set the frequency to 433.92 MHz.
2. Record the signal while the target uses their remote.
3. Highlight the captured waveform and click "Send" to replay the signal and open the barrier.

*(Note: Modern systems use "Rolling Codes" to prevent this, which require more advanced "Rolljam" attacks).*

### 2. GPS Spoofing
Drones, shipping vessels, and VIP convoys rely on GPS to know where they are. Civilian GPS signals are unencrypted and unauthenticated. An attacker with a HackRF can broadcast fake GPS signals louder than the actual satellites, tricking the target device into thinking it is somewhere else.

**Execution (using hackrf_transfer and gps-sdr-sim):**
1. Generate a fake GPS trajectory file targeting a specific coordinate (e.g., routing a drone into a no-fly zone to force it to land).
```bash
./gps-sdr-sim -e brdc3540.14n -l 38.8894,-77.0352,100 -b 8 -o spoofed_gps.bin
```
2. Broadcast the fake GPS signal via HackRF on 1575.42 MHz (L1 Frequency):
```bash
hackrf_transfer -t spoofed_gps.bin -f 1575420000 -s 2600000 -a 1 -x 0
```
*Warning: Broadcasting GPS signals is highly illegal and violates FCC/international airspace laws. Do this only inside an RF-shielded Faraday cage.*

### 3. Satellite Interception (Inmarsat / Iridium)
Ships at sea, isolated military outposts, and private jets use satellite internet. Downlink signals (from the satellite to the earth) cover massive geographical areas. Using an RTL-SDR and a specialized L-Band patch antenna, you can capture unencrypted pager messages and data streams from the sky.

**Execution (using gr-iridium):**
By tuning your SDR to the 1616 - 1626 MHz range, you can capture Iridium satellite bursts and decode raw data frames traversing the network, potentially uncovering unencrypted VIP communications or telemetry data.
