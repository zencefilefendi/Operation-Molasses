# 🤖 Offensive CI/CD (The Attack Bot)

Why pay for a Virtual Private Server (VPS) to run basic reconnaissance when you can use Microsoft's infrastructure for free? 

In the realm of Advanced Persistent Threats, CI/CD pipelines are not just for deploying code; they are **ephemeral attack nodes**. 

## 🍯 The Zencefil Attack Bot

We have integrated an Offensive CI/CD pipeline into this repository. Located at `.github/workflows/offensive-recon.yml`, this GitHub Action turns your repo into a click-and-shoot recon weapon.

### How it Works:
1. It uses `workflow_dispatch`, meaning you can trigger it manually from the GitHub UI.
2. It spins up a fresh, untraceable Ubuntu runner hosted by GitHub.
3. It silently installs `nmap`, `whois`, and `subfinder`.
4. It executes the `zencefil-recon.sh` script against your chosen target.
5. It zips the findings and uploads them as an "Artifact" for you to download. Once downloaded, the ephemeral server destroys itself, leaving no trace.

### How to use it:
1. Go to the **Actions** tab in your GitHub repository.
2. Click on **🥷 Zencefil Attack Bot (Automated Recon)** on the left sidebar.
3. Click the **Run workflow** dropdown on the right.
4. Enter your target domain (e.g., `tesla.com`).
5. Click **Run workflow**. 
6. Wait for the job to finish and download your loot from the "Artifacts" section.

*Stealthy, free, and efficient. That is the Zencefil way.*
