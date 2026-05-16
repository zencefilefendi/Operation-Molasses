# 🥷 Advanced C2 Infrastructure & Stealth

Welcome to the APT-Level operational zone. When deploying payloads, exposing your real Command & Control (C2) server is a beginner's mistake. Advanced Persistent Threats (APTs) hide their traffic behind high-reputation domains (Domain Fronting) or Cloud Redirectors.

## 🍯 Terraform: The Stealth Redirector

In the `terraform/` directory, you will find an Infrastructure-as-Code template written by **Zencefil Efendi**.

### What it does:
This script deploys an AWS API Gateway with an innocent name (`cdn-health-check`). Your malicious payload on the target machine will communicate with a highly trusted `*.execute-api.us-east-1.amazonaws.com` domain. AWS will silently proxy this traffic back to your real, hidden C2 server (like Mythic or Cobalt Strike). 

This bypasses many network egress filters because blocking AWS API Gateway is often impossible for organizations without breaking their own infrastructure.

### Deployment:
```bash
cd terraform/
terraform init
terraform apply -var="c2_server_url=https://YOUR_REAL_C2_IP:PORT"
```
The output will give you the clean AWS URL to use in your implants.
