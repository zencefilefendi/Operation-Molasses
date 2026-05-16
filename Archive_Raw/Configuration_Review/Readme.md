

# Configuration Review in Penetration Testing

## What is Configuration Review?

A **configuration review** is a methodical process in penetration testing where the tester examines system, application, network, and infrastructure settings to identify **security misconfigurations** that could lead to vulnerabilities. It is one of the most overlooked but **critical components** in any security assessment.

This phase often involves **manual inspection** and the use of automated tools to validate if systems follow **security best practices** and  **organization-specific hardening guidelines** .

---

## Objectives of a Configuration Review

* Identify insecure default settings.
* Discover unnecessary services or ports.
* Ensure secure access controls and permissions.
* Validate encryption settings (e.g., SSL/TLS).
* Check for outdated software or missing patches.
* Confirm logging, monitoring, and auditing configurations.
* Evaluate adherence to regulatory or compliance standards (e.g., PCI DSS, ISO 27001, NIST).

---

## What to Review (Key Areas)

### 1. **Operating System (OS) Configuration**

* Are unnecessary services or daemons running?
* Are default credentials still in place?
* Are firewalls (e.g., iptables, Windows Firewall) configured properly?
* Are secure boot and kernel hardening enabled?

### 2. **Web Servers (e.g., Apache, Nginx, IIS)**

* Are directory listings disabled?
* Are error messages exposing server info?
* Is `X-Frame-Options` or `Content-Security-Policy` set?
* Is SSL enforced, and are weak ciphers disabled?

### 3. **Database Servers**

* Are databases exposed on public IPs?
* Are strong authentication mechanisms in place?
* Is logging enabled for queries and login attempts?
* Are permissions overly permissive (e.g., `GRANT ALL`)?

### 4. **Network Devices (Routers, Firewalls, Switches)**

* Is Telnet disabled in favor of SSH?
* Are management interfaces accessible from the internet?
* Are default SNMP community strings changed?
* Are ACLs (Access Control Lists) correctly implemented?

### 5. **Cloud Infrastructure (AWS, Azure, GCP)**

* Are public S3 buckets properly secured?
* Are IAM roles overly permissive?
* Are access keys exposed in source code?
* Is multi-factor authentication (MFA) enabled?

### 6. **Containers and Orchestration (Docker, Kubernetes)**

* Are containers running as root?
* Are images pulled from untrusted sources?
* Is the Kubernetes dashboard open to the internet?
* Are secrets stored securely (e.g., not in environment variables)?

### 7. **Active Directory & Domain Controllers**

* Are unused user accounts disabled?
* Is password policy enforced?
* Are users part of unnecessary privileged groups?
* Are event logs and auditing enabled?

---

## Sample Checks and Payloads

| Area        | Misconfiguration  | Test / Check                              |
| ----------- | ----------------- | ----------------------------------------- |
| Web Server  | Directory Listing | Visit `http://example.com/files/`       |
| Database    | Default Creds     | `mysql -u root -p`(try empty password)  |
| OS          | Open Ports        | `nmap -sV -Pn <target-ip>`              |
| Cloud (AWS) | Public S3 Bucket  | `aws s3 ls s3://bucket-name`            |
| Kubernetes  | Dashboard Access  | Access via `http://<master-ip>:8001/ui` |
| Network     | Exposed SNMP      | `snmpwalk -v2c -c public <target-ip>`   |

---

## Best Practices to Recommend (If Found Misconfigured)

* Disable unnecessary services and ports.
* Enforce strong password policies.
* Use secure protocols (HTTPS, SSH).
* Apply least privilege principle.
* Enable and monitor audit logs.
* Regularly apply patches and updates.
* Harden system configurations using guides (e.g., CIS Benchmarks).

---

## 🛠 Tools for Configuration Review

| Tool                        | Purpose                                            |
| --------------------------- | -------------------------------------------------- |
| **Lynis**             | Linux/Unix security auditing                       |
| **nipper**             | Configuration security review                       |
| **OpenVAS**           | Vulnerability scanning including misconfigurations |
| **Nessus**            | Comprehensive system vulnerability scans           |
| **ScoutSuite**        | Cloud configuration assessment                     |
| **Kube-bench**        | Kubernetes CIS benchmark checks                    |
| **Prowler**           | AWS security configuration review                  |
| **Auditpol**(Windows) | Local security policy audit                        |
| **Nmap**              | Service discovery and port scanning                |

---

## Sample Report Snippet

```
Finding: Apache Server Exposes Directory Listings
Risk: Medium
Impact: An attacker may enumerate files and gather sensitive information.
Recommendation: Set `Options -Indexes` in Apache config.

Finding: MySQL allows root login without password
Risk: Critical
Impact: Full database compromise.
Recommendation: Set a strong password for root, disable remote root access.
```

---

## Common Pitfalls

* Trusting default configurations from vendors.
* Overlooking cloud-specific settings.
* Weak or absent logging/auditing.
* Poor segmentation and role-based access controls.
* Ignoring dev/test environments.

---

## Summary

Configuration review is a **foundational** step in penetration testing and often leads to **critical findings** that would be missed by automated scans alone. By thoroughly examining configurations, you enhance the **overall security posture** of the environment and reduce the attack surface significantly.

