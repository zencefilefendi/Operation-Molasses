# SCA Assessment

>Modern applications are built from many third-party components and run in containers and cloud infrastructure. Technologies like SBOM and SCA provide visibility into what software is used, while CVE scanning identifies known security issues. Image, container, filesystem, and IaC scanning ensure vulnerabilities, misconfigurations, and secrets are detected across the entire software lifecycle from development to production.

## SCA : Capability Comparison

| Capability                          | `grep`         | **Trivy**      | **Checkov**        | Priority    |
| ----------------------------------- | -------------- | -------------- | ------------------ | ----------- |
| Known Vulnerabilities (CVE)         | ❌ No           | ✅ Yes          | ✅ Yes              | 🔴 Critical |
| OS package vulnerabilities          | ❌ No           | ✅ Yes          | ✅ Yes              | 🔴 Critical |
| Application dependency CVEs         | ❌ No           | ✅ Yes          | ✅ Yes              | 🔴 Critical |
| Software Composition Analysis (SCA) | ❌ No           | ✅ Yes          | ✅ Yes              | 🔴 Critical |
| Misconfiguration detection          | ❌ No           | ✅ Yes          | ✅ Yes              | 🔴 Critical |
| Infrastructure as Code (IaC) scan   | ❌ No           | ✅ Yes          | ✅ Yes              | 🔴 Critical |
| Kubernetes (YAML, Helm, Kustomize)  | ❌ No           | ✅ Yes          | ✅ Yes              | 🔴 Critical |
| Docker image scan                   | ❌ No           | ✅ Yes          | ✅ Yes              | 🟠 High     |
| Dockerfile scan                     | ⚠️ Text match  | ✅ Yes          | ✅ Yes              | 🟠 High     |
| Compliance / policy checks          | ❌ No           | ⚠️ Limited     | ✅ Yes              | 🟠 High     |
| Graph-based analysis                | ❌ No           | ❌ No           | ✅ Yes              | 🟠 High     |
| Runtime security / container scan   | ❌ No           | ⚠️ Image-based | ❌ No               | 🟡 Medium   |
| Secrets detection                   | ⚠️ Basic match | ✅ Yes          | ⚠️ Limited         | 🟡 Medium   |
| Static code analysis                | ❌ No           | ⚠️ Limited     | ✅ Yes              | 🟡 Medium   |
| Filesystem scan                     | ⚠️ Text only   | ✅ Yes          | ⚠️ IaC & code only | 🟢 Low      |
| Text / keyword search               | ✅ Yes          | ❌ No           | ❌ No               | 🟢 Low      |
| SBOM generation                     | ❌ No           | ✅ Yes          | ❌ No               | 🟢 Low      |


## Comprehensive Security & Container Scanning Terminology

| Term                                    | What It Is                                      | What Gets Scanned                                | Why It Matters                                                                     |
| --------------------------------------- | ----------------------------------------------- | ------------------------------------------------ | ---------------------------------------------------------------------------------- |
| **SBOM** (Software Bill of Materials)   | A complete inventory of all software components | OS packages, libraries, versions, dependencies   | Lets you know **exactly what’s inside** your software and respond fast to new CVEs |
| **SCA** (Software Composition Analysis) | Security analysis of third-party libraries      | Open-source dependencies, transitive deps        | Most apps are open source — this finds **hidden risks**                            |
| **IaC** (Infrastructure as Code)        | Code that defines infrastructure                | Kubernetes YAML, Terraform, Helm, CloudFormation | Prevents **insecure cloud and cluster setups**                                     |
| **Docker Image**                        | Static app package                              | OS, packages, app code, libraries                | Finds vulnerabilities **before deployment**                                        |
| **Container**                           | Running Docker image                            | Runtime OS, packages, processes                  | Detects risks in **what is actually running**                                      |
| **Filesystem Scan**                     | Scan of local or repo files                     | Source code, configs, manifests                  | Catches issues **early in development**                                            |
| **Kubernetes Files (K8s)**              | Deployment and cluster configs                  | YAML files for pods, services, RBAC              | Prevents **privilege escalation and exposure**                                     |
| **Known Vulnerability (CVE)**           | Publicly disclosed security flaw                | Mapped to packages and versions                  | Standard way to **identify and track threats**                                     |
| **OS Package Vulnerability**            | Flaws in OS-level software                      | glibc, openssl, bash, apk/apt/yum pkgs           | OS bugs are often **high impact**                                                  |
| **Application Dependency**              | Libraries used by your app                      | npm, pip, maven, go, ruby deps                   | App vulnerabilities often come from **dependencies**                               |
| **Transitive Dependency**               | Dependency of a dependency                      | Hidden libraries                                 | Major source of **unexpected risk**                                                |
| **Misconfiguration**                    | Unsafe or weak settings                         | Privileged containers, open ports                | Misconfigs cause **real-world breaches**                                           |
| **Secrets**                             | Sensitive credentials in code                   | API keys, passwords, tokens                      | Prevents **credential leaks**                                                      |


---

| Term                                    | What It Is                                      | What Gets Scanned                                | Why It Matters                                                                     |
| --------------------------------------- | ----------------------------------------------- | ------------------------------------------------ | ---------------------------------------------------------------------------------- |
| **License Compliance**                  | Legal usage of open source                      | GPL, AGPL, MIT, Apache                           | Avoids **legal and compliance issues**                                             |
| **Exploitability**                      | Practical attack possibility                    | Exploit maturity, attack paths                   | Helps prioritize **what to fix first**                                             |
| **Severity**                            | Risk level of vulnerability                     | Critical / High / Medium / Low                   | Focuses effort on **most dangerous issues**                                        |
| **Fix Availability**                    | Whether a patch exists                          | Version upgrades, mitigations                    | Enables **actionable remediation**                                                 |

---

## Scan Target vs Capability Mapping

| Scan Target       | What Is Checked           | Example Tool Capability |
| ----------------- | ------------------------- | ----------------------- |
| Docker Image      | OS + app vulnerabilities  | Image scanning          |
| Running Container | Runtime packages & config | Container scanning      |
| Source Code       | Secrets, deps, configs    | Filesystem scan         |
| Kubernetes YAML   | Security best practices   | IaC scan                |
| Dependencies      | Known vulnerable libs     | SCA                     |
| Build Artifacts   | Component inventory       | SBOM generation         |

---

## Relationship Between Concepts

| Concept                | Purpose                          |
| ---------------------- | -------------------------------- |
| **SBOM**               | Visibility                       |
| **SCA**                | Risk identification              |
| **CVE**                | Standard vulnerability reference |
| **IaC scanning**       | Prevent insecure infra           |
| **Image scanning**     | Shift-left security              |
| **Container scanning** | Runtime assurance                |

---


