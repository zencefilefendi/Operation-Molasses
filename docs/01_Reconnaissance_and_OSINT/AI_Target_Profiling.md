# 🧠 AI-Assisted Target Profiling

Reconnaissance in modern operations yields gigabytes of raw data: thousands of LinkedIn profiles, leaked emails, and corporate directories. Manually sifting through this to find the perfect person to spear-phish is inefficient.

Advanced Persistent Threats (APTs) utilize automated profiling and Natural Language Processing (NLP) to filter the noise and identify **High-Value Targets (HVTs)**.

## 🍯 The Zencefil Profiler

In the tools directory, you will find a python script. This tool acts as the intelligent bridge between raw OSINT gathering and the Initial Access (Phishing) phase.

### What it does:
1.  **Data Ingestion:** Reads structured OSINT data (JSON) dumped from tools like CrossLinked or LinkedIn scrapers.
2.  **Scoring Algorithm:** Analyzes job titles and departments. It assigns high risk scores to roles with privileged access (DevOps, Cloud Admins, Finance).
3.  **Context Generation:** Based on the target's tags, it dynamically suggests the most highly-converting spear-phishing subject lines tailored to their specific department.

### Usage Example

We have provided a sample JSON file to test the script.

```bash
cd tools/
python3 zencefil_profiler.py -i sample_osint_data.json
```

**Expected Output:**
The script will ignore the Sales Representative (low privilege) and immediately highlight the DevOps Engineer and the Finance Director as prime targets, suggesting AWS or Payroll themed phishing lures for each.

### The Pipeline
Once the profiler outputs the target list and contexts, you feed this directly into the **Zencefil Ephemeral Phishing Node** (Phase 11) to execute the campaign.
