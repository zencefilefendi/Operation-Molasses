Welcome to the Web Application Penetration Testing repository. You will get help with OWASP standard references, as well as common test cases that get performed in real life i.e day to day in company.

> OWASP 2025 Top 10 : https://owasp.org/Top10/2025/

> If you are a beginner, please follow the OWASP practical guide .


 | S.N | Topic                                    | Link |
|-----|------------------------------------------|------|
| 4.0 | Introduction and Objectives               | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/00-Introduction_and_Objectives/README) |
| 4.1 | Information Gathering                     | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/01-Information_Gathering/README) |
| 4.2 | Configuration and Deployment Management Testing | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/02-Configuration_and_Deployment_Management_Testing/README) |
| 4.3 | Identity Management Testing               | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/03-Identity_Management_Testing/README) |
| 4.4 | Authentication Testing                    | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/04-Authentication_Testing/README) |
| 4.5 | Authorization Testing                     | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/05-Authorization_Testing/README) |
| 4.6 | Session Management Testing                | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/06-Session_Management_Testing/README) |
| 4.7 | Input Validation Testing                  | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/README) |
| 4.8 | Testing for Error Handling                | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/08-Testing_for_Error_Handling/README) |
| 4.9 | Testing for Weak Cryptography             | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/09-Testing_for_Weak_Cryptography/README) |
| 4.10| Business Logic Testing                    | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/10-Business_Logic_Testing/README) |
| 4.11| Client-side Testing                       | [Click Here](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/11-Client-side_Testing/README) |




| S.N | Topic                                    |Link |
|-----|------------------------------------------|------|
| 1 | TOP 100 Vulnerabilities Step-by-Step Guide Handbook.pdf | [Click Here](https://github.com/m14r41/PentestingEverything/blob/main/Web%20Applications/CheckList%20and%20methodology/TOP%20100%20Vulnerabilities%20Step-by-Step%20Guide%20Handbook.pdf) |

---



# Vulnerabilities Covered in Organization's VAPT
Note: The vulnerabilities are listed based on my experiance and  common testing performed during VAPT engagements within organizations.
>The vulnerability resources are currently being updated and are a work in progress. Please check back soon for the latest information.



| **Vulnerability**                              | **URL**                                                                                                    | **Description**                                                |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------|
| XSS                                          | [XSS](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/XSS) | Injecting malicious scripts into web pages viewed by users. |
| CORS                                         | [CORS](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/CORS) | Insecure Cross-Origin Resource Sharing configurations that can lead to attacks. |
| Deserialization                               | [Deserialization](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Deserialization%20Vulnerability) |Deserialization attacks. |
| SQL Injection                                 | [SQL Injection](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/SQL%20Injection) | Injecting SQL queries to manipulate databases. |
| SSRF                                         | [SSRF](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/SSRF) | Sending requests to unintended locations through server-side code. |
| Directory Traversal                           | [Directory Traversal](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Directory%20Traversal) | Gaining unauthorized access to restricted directories and files. |
| Clickjacking                                  | [Clickjacking](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Clickjacking) | Tricks users into clicking on malicious elements by overlaying transparent layers. |
| CRLF                                  | [CRLF](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/CRLF)|Manipulates HTTP headers by injecting carriage return (%0d) and line feed (%0a) characters, potentially altering server responses or splitting them into multiple responses. |
| IDOR                                         | [IDOR](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/IDOR) | Insecure Direct Object Reference allowing unauthorized access to resources. |
| Open File Upload                              | [Open File Upload](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Open%20File%20Upload) | Allowing file uploads without proper validation, leading to security risks. |
| Open Redirect                                 | [Open Redirect](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Open%20Redirect) | Redirecting users to untrusted sites without validation. |
| Outdated TLS Version                          | [Outdated TLS Version](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Outdated%20TLS%20Version) | Using outdated TLS versions that are susceptible to attacks. |
| Session Fixation                              | [Session Fixation](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Session%20Fixation) | Exploiting session IDs to hijack user sessions. |
| Remote Code Execution (RCE)                  | [Remote Code Execution (RCE)](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Remote%20Code%20Execution%20%28RCE%29) | Running arbitrary code on a remote server. |
| Broken Authentication                        | [Broken Authentication](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Broken%20Authentication) | Vulnerabilities allowing unauthorized access due to improper authentication. |
| Application Logic Flaws                      | [Application Logic Flaws](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Application%20Logic%20Flaws) | Issues in application logic that may lead to unauthorized actions. |
| Artibtray Cookies Flag                       | [Artibtray Cookies Flag](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Artibtray%20Cookies%20Flag) | Insecure cookie configurations that may expose sensitive data. |
| Rate Limiting                                 | [Rate Limiting](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Rate%20Limiting) | Limiting the number of requests to mitigate attacks. |
| Reverse Shell                                 | [Reverse Shell](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Reverse%20Shell) | Gaining remote access to a server through a shell. |
| Security Header Missing                       | [Security Header Missing](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Security%20Header%20Missing) | Absence of security headers leading to vulnerabilities. |
| Server Misconfigurations                      | [Server Misconfigurations](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Server%20Misconfigurations) | Incorrect server settings exposing the application to risks. |
| Server-Side Template Injection (SSTI)       | [Server-Side Template Injection (SSTI)](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Server-Side%20Template%20Injection%20%28SSTI%29) | Injecting malicious template code on the server-side. |
| Back Button Attack                           | [Back Button Attack](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Back%20Button%20Attack) | Exploiting navigation history to perform unauthorized actions. |
| Brute Force Attack                           | [Brute Force Attack](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Brute%20Force%20Attack) | Attempts to guess passwords or cryptographic keys through trial and error. |
| Business Logic Flaw                          | [Business Logic Flaw](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Business%20Logic%20Flaw) | Errors in the application's workflow that can be exploited. |
| Cheack Llist and Exploit                     | [Cheack Llist and Exploit](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Cheack%20Llist%20and%20Exploit) | Methods to exploit vulnerabilities in checked lists. |
| Command Injection                             | [Command Injection](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Command%20Injection) | Injecting malicious commands into applications to execute arbitrary commands. |
| Cookies Related Vulnerabilities               | [Cookies Related Vulnerabilities](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Cookies%20Related%20Vulnerabilities) | Issues with cookie management that could lead to information leakage. |
| Credential Stuffing                           | [Credential Stuffing](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Credential%20Stuffing) | Using stolen credentials to gain unauthorized access. |
| Cross-Site Request Forgery (CSRF)           | [Cross-Site Request Forgery (CSRF)](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Cross-Site%20Request%20Forgery%20%28CSRF%29) | Attacking a user by sending unauthorized commands from their browser. |
| File Inclusion                                | [File Inclusion](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/File%20Inclusion) | Including files that can lead to information leakage or remote code execution. |
| HTML Injection                                | [HTML Injection](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/HTML%20Injection) | Injecting HTML code into web applications to manipulate content. |
| Host Header Injection                         | [Host Header Injection](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Host%20Header%20Injection) | Manipulating host headers to direct requests to unintended servers. |
| Improper Error Handling                       | [Improper Error Handling](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Improper%20Error%20Handling) | Insufficient error messages that can disclose sensitive information. |
| Information Disclosure                        | [Information Disclosure](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Information%20Disclosure) | Leakage of sensitive information through various means. |
| Insecure Object Storage                       | [Insecure Object Storage](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Insecure%20Object%20Storage) | Poorly secured object storage leading to unauthorized access. |
| Insufficient Security Controls                | [Insufficient Security Controls](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Insufficient%20Security%20Controls) | Lack of adequate security measures that expose vulnerabilities. |
| Insufficient Transport Layer Protection       | [Insufficient Transport Layer Protection](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Insufficient%20Transport%20Layer%20Protection) | Weaknesses in transport layer security leading to potential attacks. |
| Misconfigured HTTP Headers                    | [Misconfigured HTTP Headers](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Misconfigured%20HTTP%20Headers) | Incorrectly configured HTTP headers that can be exploited. |
| Path Traversal                                | [Path Traversal](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Path%20Traversal) | Exploiting the file path to access unauthorized files. |
| Privilege Escalation                          | [Privilege Escalation](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Privilege%20Escalation) | Gaining elevated access rights to perform unauthorized actions. |
| Race Condition                                | [Race Condition](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Race%20Condition) | Exploiting the timing of processes to manipulate actions. |
| Subdomain TakeOver                            | [Subdomain TakeOver](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Subdomain%20TakeOver) | Gaining control over subdomains that are not properly configured. |
| Unrestricted File Upload                      | [Unrestricted File Upload](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Unrestricted%20File%20Upload) | Allowing file uploads without validation leading to risks. |
| Unsecured API Endpoints                       | [Unsecured API Endpoints](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Unsecured%20API%20Endpoints) | API endpoints that do not implement proper security measures. |
| Unvalidated Redirects and Forwards            | [Unvalidated Redirects and Forwards](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Unvalidated%20Redirects%20and%20Forwards) | Redirecting users without proper validation, leading to risks. |
| Weak Ciphers                                  | [Weak Ciphers](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Weak%20Ciphers) | Utilizing outdated or weak encryption algorithms. |
| Web Cache Deception                           | [Web Cache Deception](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Web%20Cache%20Deception) | Exploiting web caching mechanisms to serve malicious content. |
| WordPress                                     | [WordPress](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/WordPress) | Security vulnerabilities associated with WordPress installations. |
| XML External Entity (XXE)                    | [XML External Entity (XXE)](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/XML%20External%20Entity%20%28XXE%29) | Attacking XML parsers to extract sensitive information. |
| Tabnabbing                                   | [Tabnabbing](https://github.com/m14r41/PentestingEverything/tree/main/Web%20Applications/Vulnerabilities/Tabnabbing) | Redirecting users to a different page in a newly opened tab. |



# Common Test Cases


## Authentication & Session Issues 

| Vulnerability           | Common Issues Found                                                                                           |
| ----------------------- | ------------------------------------------------------------------------------------------------------------- |
| Broken Authentication   | Login bypass via SQLi, default creds (admin/admin), weak password policy, no lockout, predictable flow        |
| Weak Password Policy    | Short passwords allowed, no complexity, reused passwords accepted, no history check, common passwords allowed |
| Credential Stuffing     | No rate limit, reused passwords work, no CAPTCHA, no IP blocking, no MFA                                      |
| Brute Force             | Unlimited attempts, no delay, no lockout, weak detection, no alerts                                           |
| Session Fixation        | Session ID not regenerated, attacker sets session, reused session after login, no validation                  |
| Session Hijacking       | Cookies stolen via XSS, no Secure flag, session reuse, no IP/device binding, predictable tokens               |
| Missing Session Timeout | Sessions valid for long time, no idle timeout, persistent login, no forced logout                             |
| Broken Logout           | Session still active after logout, token not invalidated, back button access works, multiple sessions active  |
| Concurrent Login        | Login mutiple browser or device at the same time                                                              |
| Cookie Issues           | Missing HttpOnly, no Secure flag, no SameSite, cookies accessible via JS, weak scope                          |
| Session Prediction      | Sequential session IDs, guessable tokens, weak randomness, predictable patterns                               |
| Two-Factor Bypass       | 2FA optional, bypass via API, token reuse, no enforcement, backup codes weak                                  |
| Password Reset Flaws    | Predictable tokens, no expiry, reusable links, user enumeration, no verification                              |

---

## Access Control Issues 

| Vulnerability                 | Common Issues Found                                                                             |
| ----------------------------- | ----------------------------------------------------------------------------------------------- |
| IDOR                          | Change ID in URL, access other users’ data, edit profiles, download чуж files, API ID tampering |
| Missing Authorization         | API works without auth, direct URL access, frontend-only checks, no backend validation          |
| Improper Access Control       | Weak role checks, bypass restrictions, hidden endpoints exposed, inconsistent rules             |
| Privilege Escalation          | User becomes admin, role param modified, accessing restricted APIs, bypassing checks            |
| Vertical Escalation           | Normal user → admin panel, admin APIs exposed, role upgrade possible                            |
| Horizontal Escalation         | Access other users’ data, modify accounts, read private info                                    |
| Forced Browsing               | Access hidden endpoints, guessing URLs, bypass navigation flow                                  |
| Mass Assignment               | Extra fields accepted, role=admin injected, hidden fields trusted                               |
| Parameter Tampering           | Modify price, quantity, role, IDs, discount values                                              |
| Business Logic Flaw           | Skip steps, bypass payment, multiple coupon use, workflow abuse                                 |
| Price Manipulation            | Change price client-side, intercept requests, negative values, free purchase                    |
| Missing Function Level Access | Restricted functions exposed via API, no role checks                                            |

---

## Injection Vulnerabilities 

| Vulnerability                 | Common Issues Found                                                        |
| ----------------------------- | -------------------------------------------------------------------------- |
| SQL Injection                 | `' OR 1=1`, data dump, login bypass, union queries, error-based extraction |
| Blind SQL Injection           | Time-based delays, boolean-based, no visible output                        |
| NoSQL Injection               | JSON injection, bypass auth, query manipulation                            |
| Command Injection             | `; ls`, `&& whoami`, execute OS commands, chain commands                   |
| Code Injection                | Execute arbitrary code, eval misuse, dynamic execution                     |
| LDAP Injection                | Manipulate LDAP queries, bypass login, extract directory data              |
| XPath Injection               | Modify XML queries, bypass auth, extract data                              |
| SSTI                          | `{{7*7}}`, access server objects, read configs, RCE                        |
| XXE                           | Read `/etc/passwd`, SSRF, file disclosure, DoS                             |
| CRLF Injection                | Header injection, response splitting, cookie manipulation                  |
| HTTP Parameter Pollution      | Duplicate params override values, bypass filters                           |
| Template Injection            | Unsafe rendering of user input, server-side execution                      |
| Expression Language Injection | Inject EL expressions, access server data                                  |
| ORM Injection                 | Manipulate ORM queries, bypass logic                                       |

---

## Client-Side Issues

| Vulnerability               | Common Issues Found                                            |
| --------------------------- | -------------------------------------------------------------- |
| XSS                         | `<script>` injection, cookie theft, session hijack, defacement |
| Stored XSS                  | Persistent scripts, affects all users, stored in DB            |
| DOM XSS                     | JS handles input unsafely, URL fragment injection              |
| Clickjacking                | No X-Frame-Options, hidden iframe attacks                      |
| Tabnabbing                  | Replace original tab, phishing page                            |
| Reverse Tabnabbing          | Missing `noopener`, opener access                              |
| DOM Clobbering              | Overwriting DOM elements, JS manipulation                      |
| Prototype Pollution         | Modify JS objects globally                                     |
| Client-Side Validation Only | No server validation, bypass via request                       |
| Sensitive Data in JS        | Tokens/keys exposed in frontend                                |

---

## File Handling Issues 

| Vulnerability        | Common Issues Found                           |
| -------------------- | --------------------------------------------- |
| File Upload          | Upload web shells, no validation, MIME bypass |
| Unrestricted Upload  | Execute uploaded files, no restrictions       |
| File Upload Bypass   | Double extensions, null byte bypass           |
| LFI                  | Include local files, read configs             |
| RFI                  | Remote file execution                         |
| Path Traversal       | `../` access system files                     |
| File Download Issues | Download arbitrary files                      |
| Directory Listing    | File structure exposed                        |
| Backup Files         | `.bak`, `.old`, accessible                    |
| Log File Exposure    | Logs readable, sensitive data inside          |

---

## API & Web Services 

| Vulnerability             | Common Issues Found             |
| ------------------------- | ------------------------------- |
| Unsecured API             | No auth, open endpoints         |
| Excessive Data Exposure   | Returns unnecessary data        |
| Lack of Rate Limiting     | Abuse APIs easily               |
| SSRF                      | Access internal services        |
| CORS Misconfiguration     | `*` origin, credentials allowed |
| GraphQL Misconfig         | Introspection enabled           |
| WebSocket Issues          | No authentication               |
| API Versioning Issues     | Old insecure APIs accessible    |
| Improper Input Validation | No validation on API            |
| Insecure Serialization    | Unsafe data handling            |

---

## Security Misconfiguration 

| Vulnerability             | Common Issues Found    |
| ------------------------- | ---------------------- |
| Missing Security Headers  | No CSP, HSTS, Permission Policy X-Framer Options, X-Conten-Type Options etc. |
| CSP Misconfiguration      | Too permissive         |
| Debug Mode Enabled        | Internal data leak     |
| Verbose Errors            | Stack traces           |
| Default Credentials       | Admin/admin works      |
| Content Type confuction   | Force browser to load and executed content type   |
| Directory Listing Enabled | File browsing          |
| CDN Misconfiguration      | Sensitive data cached  |
| Third-party Script Risk   | External JS compromise |
| Web Cache Deception      | Cached sensitive data by frontent |
| Third-party Script Risk   | External JS compromise |
| Trace Method Enable   | Check if Trace Method is enabled |




---

## Data Exposure & Storage 

| Vulnerability            | Common Issues Found       |
| ------------------------ | ------------------------- |
| Information Disclosure   | Sensitive data leak       |
| Sensitive Files Exposure | `.env`, configs           |
| Hardcoded Secrets        | API keys in code          |
| Insecure Storage         | Plaintext passwords       |
| Weak Hashing             | MD5/SHA1 used             |
| Mixed Content            | HTTP in HTTPS             |
| Referrer Leak            | Sensitive data in headers |
| Browser Storage Issues   | Tokens in localStorage    |

---

## Advanced & Logic Issues 

| Vulnerability           | Common Issues Found        |
| ----------------------- | -------------------------- |
| Race Condition          | Double spending            |
| JWT Issues              | Weak secret, no validation |
| OAuth Misconfig         | Token leakage              |
| SSO Issues              | Weak trust model           |
| CAPTCHA Bypass          | Automation possible        |
| Workflow Bypass         | Skip steps                 |
| Replay Attack           | Reuse requests             |
| State Management Issues | Inconsistent app state     |

---

## Network & Transport

| Vulnerability         | Common Issues Found |
| --------------------- | ------------------- |
| Missing HTTPS         | HTTP used           |
| Weak TLS              | Weak ciphers        |
| Outdated TLS          | Deprecated versions |
| Host Header Injection | Reset poisoning     |
| Subdomain Takeover    | Dangling DNS        |
| Web Cache Issues      | Cache poisoning     |




