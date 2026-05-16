

# Understanding Threat Modeling in SDLC 

Before understanding **Threat Modeling**, it is important to understand where it fits in the **Software Development Life Cycle (SDLC)** and what happens before security testing begins.

Security is not something that starts after development  i.e it starts from the very beginning of the system idea.

---

# SDLC Flow Normally (Security Point of View)

> From a product security perspective, the early phases of SDLC look like this:

| Stage               | Description                           |
| ------------------- | ------------------------------------- |
| Idea Review         | Identify early risks at concept stage |
| Design Review       | Check security in design & APIs       |
| Architecture Review | Review full system structure          |
| Threat Modeling     | Identify and simulate attacks         |
| Development         | Secure coding implementation          |
| Testing             | Find vulnerabilities in real system   |
| Deployment          | Monitor and respond to attacks        |

---

## 1. Idea Review (Requirement Stage)

Idea review is the earliest stage of SDLC where a product or feature is still just a concept. At this stage, the focus is on understanding what we are building, why we are building it, and what type of data will be used. The security goal is to identify basic risks before any design or development starts. For example, if a file upload feature is planned, we think about whether users can upload malicious files, where those files will be stored, and who will have access to them. At this stage, security thinking is only high-level and conceptual.


## 2. Design Review

Design review happens when the system design starts taking shape, including APIs, database structure, and user flows. The focus is on API structure, authentication flow, data flow between components, and external integrations. The security goal is to identify design-level flaws before coding begins. For example, missing authorization in API design can lead to IDOR risks, sensitive data may be sent without encryption, or client-side validation may be wrongly trusted. This stage is mainly about making secure design decisions before implementation.


## 3. Architecture Review

Architecture review is performed when the full system structure is defined, including frontend, backend, database, and external services. The focus is on understanding system components, trust boundaries, third-party integrations, and network communication between services. The security goal is to identify system-wide risks and weak trust relationships. Common issues include direct database access from multiple services, lack of network segmentation, and weak internal service security. This is a big-picture review of how the entire system is connected and protected.


## 4. Threat Modeling (Core Security Activity)

Threat modeling is a structured process used to identify, analyze, and reduce security risks in a system before it is built or released. It helps answer what can go wrong, how an attacker can exploit the system, what the impact would be, and how those risks can be fixed. It is important because it helps discover vulnerabilities early, reduces production security issues, supports secure development, and improves overall application security.

---

# OWASP Threat Modeling : Official Resources
> Understand system → Break system → Identify threats → Apply STRIDE → Mitigate → Review → Maintain

| Resource | What it is |  Description       |
|----------|------------|----------------|
| [OWASP Threat Modeling Process](https://owasp.org/www-community/Threat_Modeling_Process) | Process-based guide | Explains step-by-step how to perform threat modeling in SDLC (scope → threats → mitigation → review) |
| [OWASP Threat Modeling Guide](https://owasp.org/www-project-threat-modelling-guide/) | Learning + adoption guide | Helps teams understand how to start threat modeling and choose the right method |
| [OWASP Threat Modeling Community Page](https://owasp.org/www-community/Threat_Modeling) | General overview | Explains what threat modeling is and why it is important in security design |
| [OWASP Threat Modeling Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html) | Quick reference guide | Practical checklist for performing threat modeling in real projects |


# Real-World View 
### idea review VS design review VS architecture review VS threat modeling

| Stage                   | What it is (in real projects)                                              | How we actually perform it                                                                                               | What we do in practice                                                                                            | What we review i.e Focused Area                                                                                                            |
| ----------------------- | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| **Idea Review**         | First security checkpoint when a feature is still just a business idea     | Join requirement discussion, ask security questions early, understand user journey and data flow at high level           | Identify whether idea introduces sensitive data handling, abuse cases, compliance risk, or obvious attack surface | What data is collected, who can access it, external dependencies, obvious abuse cases (e.g., spam, file abuse, unauthorized access)          |
| **Design Review**       | Review of system design before any code is written                         | Analyze API contracts, wireframes, user flows, authentication approach, and data handling design                         | Identify design weaknesses early so developers don’t build insecure logic                                         | Authentication design, authorization model, API structure, input validation strategy, encryption plan, client vs server responsibility       |
| **Architecture Review** | Full system security validation at component level                         | Study architecture diagram (frontend, backend, DB, services), map data flows, identify trust boundaries and integrations | Ensure system design is secure at structural level and does not allow unsafe trust relationships                  | Microservices communication, database access patterns, third-party integrations, network exposure, trust boundaries, sensitive data movement |
| **Threat Modeling**     | Deep security analysis simulating attacker behavior on the designed system | Break system into components, identify assets, apply STRIDE, build attack scenarios, rate risks                          | Convert system design into attack paths and define how attackers could break it                                   | Spoofing, tampering, data leakage, privilege escalation, DoS, API abuse, SSRF, IDOR, injection points, abuse scenarios                       |


---

# Threat Modeling Practical Flow Looks like: 

| Step                 | What you do                                       |
| -------------------- | ------------------------------------------------- |
| 1. Understand system | Study architecture, APIs, data flow               |
| 2. Break system      | Divide into frontend, backend, DB, services       |
| 3. Trust boundaries  | Identify where trust changes (user → server)      |
| 4. Find threats      | Use STRIDE questions (spoof, tamper, steal, etc.) |
| 5. Attack scenarios  | Think like attacker (SQLi, IDOR, RCE, SSRF)       |
| 6. Risk rating       | Mark High / Medium / Low risk                     |
| 7. Mitigation        | Add fixes like validation, auth, encryption       |
| 8. Documentation     | Write threats, impact, and fixes                  |

# Threat Modeling Frameworks

## Security Frameworks

| Framework | What it is                 | Description                                                                         |
| --------- | -------------------------- | ------------------------------------------------------------------------------------ |
| DREAD     | Risk scoring model         | Helps prioritize threats based on how dangerous and easy they are to exploit         |
| PASTA     | Step-by-step process model | Structured way to analyze threats from business goal to attack scenarios             |
| LINDDUN   | Privacy-focused model      | Identifies privacy risks like data leakage, tracking, and user identification issues |

---

## 1. DREAD (Risk Rating Model)
> Used to decide which vulnerability is most critical first.

| Factor          | Meaning                                  |
| --------------- | ----------------------------------------- |
| Damage          | How bad the impact is if attack succeeds  |
| Reproducibility | How easily attacker can repeat the attack |
| Exploitability  | How easy it is to exploit                 |
| Affected Users  | How many users get impacted               |
| Discoverability | How easy it is to find the vulnerability  |

## 2. PASTA (Threat Modeling Process)
> Used for deep and structured threat analysis.

| Step                      | What it means                |
| ------------------------- | ---------------------------- |
| 1. Define objectives      | Understand business goal     |
| 2. Technical scope        | Define system boundaries     |
| 3. Application breakdown  | Break system into components |
| 4. Threat identification  | Find possible threats        |
| 5. Vulnerability analysis | Check weaknesses             |
| 6. Attack modeling        | Simulate attacker behavior   |
| 7. Risk analysis          | Prioritize risks             |


## 3. LINDDUN (Privacy Model)
> Used when privacy is important (GDPR-type systems).

| Category        | Description                        |
| --------------- | ---------------------------------- |
| Linkability     | Can data be linked to a user?      |
| Identifiability | Can user be identified?            |
| Non-repudiation | Can user deny actions?             |
| Detectability   | Can presence/activity be detected? |
| Disclosure      | Is private data exposed?           |
| Unawareness     | User unaware of data usage         |
| Non-compliance  | Violates privacy laws/policies     |


