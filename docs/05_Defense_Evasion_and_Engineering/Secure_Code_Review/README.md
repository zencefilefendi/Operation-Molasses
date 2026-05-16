# SAST - Static Application Security Testing

## What is Source Code Review?
A secure code review is a line-by-line analysis of the source code of an application, usually performed to find any security risks overlooked during the pre or post-development phase. A secure code review aims to analyze an application's source code and determine whether it has any security vulnerabilities or flaws.

> Stay Updated With Official OWASP SAST Guide: https://owasp.org/www-community/Source_Code_Analysis_Tools


### Awesome Resources

>Assetnote Research Notes :  https://www.assetnote.io/resources/research </br>
>Sample Fortify Audit Workbench Report : [Web-Goat]( https://github.com/m14r41/PentestingEverything/blob/main/Secure%20Code%20Review/Sample-Reports/WebGoat-%20DeveloperWorkbook-Fortify%20Scan%20Results.pdf)



| Credit                                                      | Link                                                                  |
|-------------------------------------------------------------|-----------------------------------------------------------------------|
| [Cobalt.io](https://www.cobalt.io/blog/a-pentesters-guide-to-source-code-review)               | [A Pentester's Guide to Source Code Review](https://www.cobalt.io/blog/a-pentesters-guide-to-source-code-review)   |
| [Cobalt.io](https://www.cobalt.io/blog/source-code-review)               | [Source Code Review](https://www.cobalt.io/blog/source-code-review)   |
| [@prasad508](https://medium.com/@prasad508/how-to-series-source-code-review-part-1-458b3a8d9569)             | [How to Series: Source Code Review Part 1](https://medium.com/@prasad508/how-to-series-source-code-review-part-1-458b3a8d9569) |
| [codegrip.tech ](https://www.codegrip.tech/productivity/best-practices-for-reviewing-code/)          | [Best Practices for Reviewing Code](https://www.codegrip.tech/productivity/best-practices-for-reviewing-code/) |
| [YouTube - @HackerVlog ](https://www.youtube.com/watch?v=MSM1_y8Ih3A)          | [Video 1](https://www.youtube.com/watch?v=MSM1_y8Ih3A) |
| [YouTube - @hackervloglive](https://www.youtube.com/watch?v=Ft-1hjns0-Y)          | [Video 2](https://www.youtube.com/watch?v=Ft-1hjns0-Y) |
| [YouTube - @HackerVlog](https://www.youtube.com/watch?v=YlhDmJyQEGk)          | [Video 3](https://www.youtube.com/watch?v=YlhDmJyQEGk) |
| [OWASP](https://owasp.org/www-community/Source_Code_Analysis_Tools)           | [Source Code Analysis Tools](https://owasp.org/www-community/Source_Code_Analysis_Tools) |
| [Palo Alto Networks](https://www.paloaltonetworks.com/cyberpedia/what-is-sast-static-application-security-testing) | [What is SAST - Static Application Security Testing](https://www.paloaltonetworks.com/cyberpedia/what-is-sast-static-application-security-testing) |
| [Mend.io](https://www.mend.io/blog/sast-static-application-security-testing/) | [SAST - Static Application Security Testing](https://www.mend.io/blog/sast-static-application-security-testing/) |
| [Snyk](https://snyk.io/learn/application-security/static-application-security-testing/)           | [Static Application Security Testing](https://snyk.io/learn/application-security/static-application-security-testing/) |
| [SonarSource](https://www.sonarsource.com/solutions/security/)          | [SonarSource Security Solutions](https://www.sonarsource.com/solutions/security/) |





---
**Common Tools Free and Paid:**
| Open Source Tools                                                                          | Source Code Review Commercial                                                                       |
| ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------- |
| [SonarQube Download](https://sonarqube.org/downloads)                                      | [Checkmarx Static Application Security Testing (SAST)](https://www.checkmarx.com/)                  |
| [Semgrep](https://semgrep.dev/docs/getting-started/quickstart)                | [AppScan Source - HCL](https://www.hcltechsw.com/wps/portal/products/appscan)                       |
| [Snyk](https://snyk.io/docs/getting-started/install-cli/)                         | [Fortify](https://www.microfocus.com/en-us/cyberres/application-security/static-code-analysis-sast) |
| [Betterscan-ce ](https://github.com/checkmarx-ltd/better-scan)                     | [Klocwork](https://www.roguewave.com/products/klocwork)                                             |
| [VCG - VisualCodeGrepper](https://github.com/Arachni/arachni/wiki/VCG---VisualCodeGrepper) | [Veracode](https://www.veracode.com/)                                                               |
| [Yasca - Yet Another Source Code Analyzer](https://github.com/scovetta/yasca)              |                                                                                                     |
| [Findbugs](https://find-sec-bugs.github.io/)                                               |                                                                                                     |
| [RIPS Scanner](https://www.ripstech.com/download/)                                         |                                                                                                     |
| [OWASP Orizon](https://owasp.org/www-project-orizon/)                                      |                                                                                                     |
| [LAPSE](https://github.com/sourceclear/lapse)                                              |                                                                                                     |
| [FxCOP](https://github.com/dotnet/roslyn-analyzers)                                        |                                                                                                     |
| [RATS](https://github.com/andlabs/rats)                                                    |                                                                                                     |
| [Raptor](https://github.com/viper-framework/raptor)                               |                                                                                                     |




---
# Code Review Checklist

| Credits | https://github.com/mgreiler | [awesomecodereviews.com](https://www.awesomecodereviews.com/) |
| ------- | --------------------------- | ------------------------------------------------------------- |
|         |                             |                                                               |

# List of common Vulnerability 


| #  | Vulnerability / Risk                                | Typical Functions / Areas to Inspect                                                                                                         |
| -- | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | SQL Injection (SQLi)                                | `exec()`, `query()`, `mysqli_query()`, `PDO->query()`, dynamic SQL concatenation                                                             |
| 2  | Command Injection / OS Injection                    | `system()`, `exec()`, `popen()`, `Runtime.getRuntime().exec()`, shell scripts with user input                                                |
| 3  | Cross-Site Scripting (XSS)                          | `innerHTML`, `document.write()`, `eval()`, template rendering without escaping, React `dangerouslySetInnerHTML`, Angular `ng-bind-html`      |
| 4  | Cross-Site Request Forgery (CSRF)                   | Missing anti-CSRF tokens, state-changing requests without verification                                                                       |
| 5  | Insecure Deserialization                            | `unserialize()` (PHP), `pickle.load()` / `marshal.load()` (Python), `ObjectInputStream.readObject()` (Java), `YAML.load()` (Python/Ruby)     |
| 6  | Remote Code Execution (RCE)                         | `eval()`, `exec()`, dynamic imports, unsafe reflection, template engines                                                                     |
| 7  | Insecure Direct Object References (IDOR)            | Direct access to IDs in URLs/APIs without authorization                                                                                      |
| 8  | Hardcoded Credentials / Secrets                     | Passwords, API keys, tokens, DB credentials, encryption keys in code or config                                                               |
| 9  | Weak or Predictable Randomness                      | `rand()`, `Math.random()`, `UUID.randomUUID()` without crypto                                                                                |
| 10 | Sensitive Data Exposure                             | Logging sensitive info, debug output, URL parameters, cookies, mobile storage                                                                |
| 11 | XML External Entity (XXE)                           | `DocumentBuilderFactory`, `SAXParserFactory`, `simplexml_load_file()`, `xml.etree.ElementTree` without secure config                         |
| 12 | Server-Side Request Forgery (SSRF)                  | `file_get_contents()`, `curl_exec()`, `HttpClient` calls with untrusted input                                                                |
| 13 | File Inclusion / Path Traversal                     | `include()`, `require()`, `fopen()`, `file_get_contents()`, dynamic file paths, user input in filenames                                      |
| 14 | Insecure File Upload                                | `move_uploaded_file()`, `fwrite()`, `FileOutputStream()` without validation, executable uploads allowed                                      |
| 15 | Insecure Redirects / Open Redirect                  | `header("Location: ...")`, `response.sendRedirect()`, mobile deep links, unvalidated URL parameters                                          |
| 16 | Broken Authentication                               | Weak password policies, missing MFA, insecure password recovery, session hijacking                                                           |
| 17 | Broken Access Control                               | Missing role/authorization checks, admin functions callable by normal users, tenant segregation issues                                       |
| 18 | Weak Session Management                             | Predictable session IDs, missing expiration, missing rotation, insecure cookie flags                                                         |
| 19 | Insecure Cookies                                    | Missing `Secure`, `HttpOnly`, `SameSite` flags, storing sensitive data in cookies/localStorage                                               |
| 20 | Insecure Cryptography                               | Weak algorithms (MD5, SHA1, DES, RC4, ECB), weak key management, hardcoded keys                                                              |
| 21 | Buffer Overflow / Memory Corruption                 | `strcpy()`, `sprintf()`, `gets()`, use-after-free, double free, dangling pointers, C/C++ memory issues                                       |
| 22 | Integer Overflow / Underflow                        | Arithmetic on unvalidated integers in C/C++ or Java                                                                                          |
| 23 | Race Conditions                                     | File access, DB updates, concurrent requests modifying shared resources                                                                      |
| 24 | Insecure Logging                                    | Logging sensitive data, log forging/injection, insufficient audit trails                                                                     |
| 25 | Missing Security Headers                            | `X-Frame-Options`, `Content-Security-Policy`, `X-Content-Type-Options`, `Strict-Transport-Security`, `Referrer-Policy`, `Permissions-Policy` |
| 26 | Insecure API Endpoints                              | Missing authentication/authorization, weak rate limiting, unprotected webhooks, versioning issues                                            |
| 27 | Weak JWT Handling                                   | Missing signature verification, weak keys, long-lived tokens, missing audience/issuer checks                                                 |
| 28 | Insecure Mobile Storage                             | SharedPreferences, Keychain, SQLite storing secrets unencrypted                                                                              |
| 29 | Hardcoded Mobile Secrets                            | API keys or tokens in APK/IPA or source code                                                                                                 |
| 30 | Insecure Cloud Storage                              | Open S3/GCP/Azure buckets, missing ACLs, public read/write                                                                                   |
| 31 | Unsafe Dynamic Code Execution / Reflection          | `eval()`, `Function()`, `Class.forName()`, `Method.invoke()`, `importlib`, dynamic imports                                                   |
| 32 | Insecure XML / HTML / Template Handling             | Template rendering without sanitization, DOM injection, unsafe HTML generation                                                               |
| 33 | Insecure Use of TLS / SSL                           | Weak ciphers, expired/self-signed certificates, missing certificate validation                                                               |
| 34 | Missing Input Validation / Sanitization             | SQL, OS commands, LDAP, XPath, XML, JSON, regex inputs                                                                                       |
| 35 | ReDoS / Inefficient Regex                           | Complex regex from untrusted input causing DoS                                                                                               |
| 36 | Weak Password Storage                               | Plaintext, unsalted hashes, weak PBKDF2 iterations                                                                                           |
| 37 | Unsafe File / Directory Permissions                 | World-readable/writable files, insecure file ownership                                                                                       |
| 38 | Unrestricted File Operations                        | Overwriting/deleting files, unsafe temp files, predictable filenames                                                                         |
| 39 | Insecure Compression / Archive Handling             | Zip bombs, decompression DoS, unsafe file extraction                                                                                         |
| 40 | Business Logic Vulnerabilities                      | Negative payments, discount bypass, multi-tenant data leaks, bypassing expected rules                                                        |
| 41 | Insecure Event Handling / Background Tasks          | Unvalidated events, cron jobs processing untrusted input                                                                                     |
| 42 | Insecure API Rate Limiting / Brute-force Protection | Login endpoints, sensitive API calls, scraping prevention                                                                                    |
| 43 | Missing MFA / Weak Auth Factors                     | Critical accounts without two-factor authentication                                                                                          |
| 44 | Insufficient Entropy / Token Generation             | Weak CSRF tokens, predictable session tokens, JWT secrets                                                                                    |
| 45 | Sensitive Data in URLs / GET Requests               | Tokens, passwords, session IDs in query strings                                                                                              |
| 46 | Open Database Ports / Weak DB Access                | Exposed MySQL/PostgreSQL, unsecured DB endpoints                                                                                             |
| 47 | Missing Error Handling / Info Leak                  | Stack traces, verbose errors exposing sensitive info                                                                                         |
| 48 | Unsafe Use of Temporary / Cache Storage             | Temp files, CDN cache, Redis/Memcached storing secrets                                                                                       |
| 49 | Weak OAuth / Access Tokens                          | Excessive scopes, missing validation, predictable refresh tokens                                                                             |
| 50 | Insecure Use of WebSockets                          | Unauthenticated WS messages, plain WS without TLS                                                                                            |
| 51 | Insecure Push Notifications / Mobile APIs           | Sensitive data in notifications, unprotected endpoints                                                                                       |
| 52 | Insufficient API Pagination / Filtering             | Exposing full datasets without limits or filters                                                                                             |
| 53 | Unsafe Cross-Origin / CORS Configuration            | `Access-Control-Allow-Origin: *`, allowing untrusted origins                                                                                 |
| 54 | Missing Input Length Checks                         | Buffer overflows, DoS from long inputs, file uploads                                                                                         |
| 55 | Unsafe File / Data Serialization                    | Deserialization of untrusted JSON, XML, pickle, marshal, YAML                                                                                |
| 56 | Insecure Temporary Credentials / Tokens             | Long expiration, no revocation, predictable tokens                                                                                           |
| 57 | Insecure Use of Reflection / Dynamic Calls          | Arbitrary method/class execution via reflection without validation                                                                           |
| 58 | Missing Audit / Monitoring                          | No logging of failed logins, sensitive actions, anomalies                                                                                    |
| 59 | Weak CAPTCHA / Bot Protection                       | Predictable or bypassable CAPTCHA on forms                                                                                                   |
| 60 | Insecure Use of Third-Party Libraries               | Known vulnerable versions, deprecated functions, unpatched dependencies                                                                      |
| 61 | DOM-based Cross-Site Scripting (DOM XSS) | Any DOM manipulation using untrusted input: `innerHTML`, `outerHTML`, `document.write()`, `eval()`, `Function()`, `setTimeout(string)`, framework bindings like `dangerouslySetInnerHTML`, `ng-bind-html`, or jQuery `.html()` |

