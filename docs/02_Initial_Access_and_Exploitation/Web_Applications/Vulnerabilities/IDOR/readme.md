
### **Insecure Direct Object Reference (IDOR)**

| **Aspect**                   | **Details**                                                                                                                                                   |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Description**              | **IDOR (Insecure Direct Object Reference)** occurs when an application exposes direct access to internal objects like user IDs, files, or account numbers **without enforcing access control**. Attackers can manipulate these references to access unauthorized resources. |
| **Conditions to be Vulnerable** | - Direct access to objects via user-controlled input without proper authorization checks. <br> - Lack of security measures to validate user permissions for accessing objects. |
| **Where to Find**            | - URL parameters that reference user data (e.g., `http://example.com/profile.php?id=123`). <br> - API endpoints allowing access to sensitive data without adequate authentication. |
| **Common Exploits**          | - **Accessing another user's profile**: An attacker modifies the ID in the URL to view or edit someone else's profile (e.g., changing `id=123` to `id=124`). <br> - **Manipulating order details**: By changing the order ID in the URL, an attacker can view other users' orders or details (e.g., `http://example.com/order.php?id=456`). |
| **Mitigation**               | - Implement proper authorization checks to ensure users can only access resources they own. <br> - Avoid exposing internal identifiers in URLs. Use indirect references (e.g., hash-based IDs) instead. |
| **Example**                  | An attacker accesses a URL `http://example.com/user/profile?id=5`, which should belong to a specific user. By changing the ID, they access the profiles of other users, leading to data exposure. |

---

### **Common Bypass Techniques and Payloads**

| **Bypass Technique**                | **Payload**                                    |
|-------------------------------------|------------------------------------------------|
| **Changing Object ID**              | `http://example.com/resource?id=2` to `id=3` |
| **Sequential Access**               | Accessing `http://example.com/resource?id=1`, `id=2`, etc. |
| **Accessing Related Resources**     | `http://example.com/resource?id=1&related=2` |
| **Guessing IDs**                    | Using common patterns or sequential IDs (e.g., `1, 2, 3, ...`). |
| **API Manipulation**                | Modifying request parameters in API calls to access unauthorized resources. |


Got it! Here's a **nicely formatted and easy-to-read Markdown table and cheatsheet** for **IDOR (Insecure Direct Object Reference)** payloads, bypasses, and testing notes:

---

#  IDOR Payloads & Bypass Cheatsheet


##  Sorted & Useful Payloads (with Context)

###  Common Payload Types

| Category           | Payload Example                             | Description                              |
|--------------------|----------------------------------------------|------------------------------------------|
| **Numeric IDs**    | `?id=1`, `?id=9999`, `?id=0001`              | Common in URLs or API params             |
| **Path Access**    | `/user/1`, `/file/2/download`                | REST API object access                   |
| **Traversal**      | `/user/../2`, `/file/../etc/passwd`          | Path traversal for hidden resources      |
| **Encoded**        | `?id=MQ==` (`1` in Base64)                   | Obfuscation bypass using Base64          |
| **UUID**           | `?id=8a93...`                                | Guessable or weak UUIDs                  |
| **JWT Tokens**     | `eyJhbGci...`                                | Decode and modify `user_id`, `role`, etc.|
| **Spoofed Headers**| `X-User-ID: 2`, `X-Forwarded-User: admin`    | Internal ID override (e.g., reverse proxy)|
| **HTTP Methods**   | `PUT /user/2`, `DELETE /order/1`             | Privilege checks missing for certain verbs|

---

##  Bypass Techniques

| Technique                  | Example                                  | Purpose                                |
|----------------------------|------------------------------------------|----------------------------------------|
| **ID Formatting**          | `?id=01`, `?id=1.0`, `?id=0x1`           | Bypass with type confusion             |
| **Method Tampering**       | Change `GET` → `POST`, `PUT`, `DELETE`  | Some endpoints validate only `GET`     |
| **Header Injection**       | Add `X-Original-User: admin`            | Backend trust via headers              |
| **Token Reuse**            | Reuse JWTs or tokens from other users   | Often no signature or validation       |
| **Resource Guessing**      | `/orders/1`, `/orders/2`                | Predictable file/user IDs              |

---

## 🎯 Real Targets for Testing

| Target Feature        | Testable Object Reference Examples          |
|------------------------|---------------------------------------------|
| **User Profiles**     | `?user_id=1`, `/profile/1`                 |
| **Orders/Invoices**   | `?order_id=2023`, `/orders/2023`           |
| **Files/Downloads**   | `?file=report.pdf`, `/files/3/download`    |
| **Reset Tokens**      | `?token=abcd1234...`                       |
| **Messages/Chats**    | `/messages/123`, `/chat/thread?id=4`      |
| **Notifications**     | `?notif_id=7`, `/alerts/2`                 |

---


## 🧰 Tools for Testing

| Tool         | Use Case                                       |
|--------------|------------------------------------------------|
| **Burp Suite** | Manual testing, Intruder, Repeater           |
| **Autorize**   | Detect broken access control in Burp         |
| **Postman**    | Token replay and API ID manipulation         |
| **ffuf / wfuzz** | Automate ID fuzzing via CLI                |
| **jwt.io**     | Decode and edit JWT tokens                   |

---

**IDOR vulnerabilities can become critical** when combined with sensitive object references or weak authorization logic. Here's a detailed breakdown in **Markdown format**, showing **how IDOR can escalate into full account takeovers, data leaks, or even admin control**.

---

# 🚨 When & Why IDOR Becomes Critical

## 💥 Critical Impacts of IDOR Vulnerabilities

| Scenario                            | How IDOR Causes It                          | Severity       |
|-------------------------------------|----------------------------------------------|----------------|
| 🔐 **Account Takeover**             | Change `user_id` in password reset link or profile edit endpoint | 🟥 Critical     |
| 📂 **Access to Sensitive Files**    | Modify `file_id` in download/view requests   | 🟧 High         |
| 🛠️ **Admin Action Execution**      | Access `admin_id` or modify roles on target users | 🟥 Critical     |
| 🧾 **Invoice / Payment Access**     | View or modify others’ invoices or transactions | 🟨 Medium-High  |
| 💬 **Read Others' Messages**        | Change `message_id` in inbox API             | 🟧 High         |
| 🧼 **Delete Another User’s Data**   | Modify `resource_id` in delete endpoint      | 🟥 Critical     |
| 📊 **Information Disclosure**       | Pull internal data via `/report?id=3`       | 🟨 Medium       |
| 🔗 **Token Replay & Abuse**         | Modify reset links or API access tokens      | 🟥 Critical     |

---

## 🛠️ Examples of Critical Exploits

### 1. 🧬 Account Takeover via IDOR

**Vulnerable Request:**
```http
POST /api/reset_password
Body: { "user_id": "123", "new_password": "new123" }
```

Change `user_id=123` → `124` (another user). If no auth check, attacker resets **someone else's password**.

---

### 2. 📂 Download Admin Files

```http
GET /download?file_id=1001
```

Guessing or modifying `file_id` could expose:
- Internal backups
- Admin-only documents
- Confidential exports

---

### 3. 🔧 Role Escalation or Privilege Hijacking

```http
POST /api/assign_role
Body: { "target_user_id": "100", "role": "admin" }
```

If no check on `who` can assign roles, a regular user becomes **admin**!

---

### 4. 🧨 Chaining with Other Vulnerabilities

| Vulnerability    | Combined with IDOR Can Lead to...             |
|------------------|------------------------------------------------|
| **CSRF**         | Auto-submit IDOR exploit via victim browser   |
| **Weak JWT**     | Bypass token-based auth + IDOR                |
| **Unvalidated Redirects** | Leak sensitive URLs/tokens            |
| **Rate-Limiting Issues** | Mass exploit IDOR (bruteforce users)  |
| **Improper Logging** | No audit trail of abuse                   |

---



## 🛡️ Unified Defensive Strategy for Critical Risk

| Layer / Measure           | Description                                                |
|---------------------------|------------------------------------------------------------|
| **Auth Layer**            | Verify *who* is making the request                         |
| **Object Ownership**      | Ensure user *owns* the object being accessed               |
| **Access Control Checks** | Always verify object ownership server-side                 |
| **Role Validation (RBAC / ABAC)** | Don’t trust client to define role/target; use Role-/Attribute-Based Access Control |
| **Use UUIDs / Indirect References** | Make object references hard to guess using UUIDs or hashed IDs |
| **Rate Limiting**         | Prevent IDOR brute-force and automated ID enumeration      |
| **Logging & Monitoring**  | Log all object accesses, detect anomalies, and alert       |




