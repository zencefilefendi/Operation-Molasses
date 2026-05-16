# **How to Identify DOM-Based XSS?**  


### Why is this a DOM-Based XSS?

 DOM-based XSS occurs when the vulnerability is in the JavaScript code running in the browser, rather than in the server-side response. The malicious script is executed purely on the client side without the server modifying the page.

How This XSS is DOM-Based

| Factor | Explanation |
|---------|----------------|
| Source | The user-controlled input comes from location.search (query string in the URL). |
| Execution in Browser | The JavaScript on the page reads location.search and inserts it into the DOM using document.write(). |
| No Server Interaction | The attack does not require modifying server responses; it happens entirely in the user's browser. |
| Vulnerable Code | javascript document.write("Search: " + location.search); |
| Why This is DOM-Based | The vulnerability exists inside the JavaScript code, not in the HTML or server response. |



## To determine if a website is vulnerable to **DOM-based XSS**, follow these steps:  

### **1️⃣ Identify User-Controlled Input Sources**  
Look for JavaScript code that takes input from the URL, cookies, or other user-controllable locations. Common sources include:  

| **Source**             | **Example** |
|------------------------|------------|
| `location.search`      | `document.write(location.search);` |
| `location.hash`        | `document.write(location.hash);` |
| `document.URL`         | `document.write(document.URL);` |
| `document.referrer`    | `document.write(document.referrer);` |
| `localStorage`         | `document.write(localStorage.getItem("data"));` |
| `sessionStorage`       | `document.write(sessionStorage.getItem("data"));` |
| `window.name`          | `document.write(window.name);` |

✅ **Check if the application reads user input from these sources.**  

---

### **2️⃣ Find Sinks (Execution Points)**  
A **sink** is where the user-controlled input is inserted into the page. If the input is inserted without sanitization, it can execute JavaScript. Dangerous sinks include:  

| **Sink**               | **Vulnerable Example** |
|------------------------|----------------------|
| `document.write()`    | `document.write(location.search);` |
| `innerHTML`           | `element.innerHTML = location.search;` |
| `outerHTML`           | `element.outerHTML = location.search;` |
| `eval()`              | `eval(location.search);` |
| `setTimeout()`        | `setTimeout(location.search, 0);` |
| `setInterval()`       | `setInterval(location.search, 0);` |
| `Function()`          | `new Function(location.search);` |
| `document.createElement()` | `var script = document.createElement("script"); script.src = location.search; document.body.appendChild(script);` |

✅ **Check if user-controlled data reaches any of these sinks.**  

---

### **3️⃣ Test by Injecting a Simple Payload**  
If you find a possible input-source and sink combination, test by injecting a **non-harmful script** like:  
```
https://example.com/search?query=<script>alert('XSS')</script>
```
If an alert box pops up, the site is vulnerable to **DOM-based XSS**.  

---

### **4️⃣ Use Browser Developer Tools**  
1. **Inspect JavaScript Code:**  
   - Open DevTools (`F12` → `Sources` tab).  
   - Search (`Ctrl + F`) for **`location.search`**, **`innerHTML`**, or other sources/sinks.  

2. **Monitor DOM Changes:**  
   - Open **DevTools Console** and run:  
     ```javascript
     Object.getOwnPropertyDescriptor(window, 'location')
     ```
   - If `location` is modified dynamically, it may be vulnerable.  

3. **Use `DOM XSS Scanner` Extensions:**  
   - Chrome/Firefox **"DOM XSS Scanner"** extensions can help detect vulnerabilities.  

---

### **5️⃣ Use Security Tools for Automated Testing**  
🔹 **Burp Suite (DOM Invader)**  
   - Can automatically detect and test for DOM XSS.  

🔹 **OWASP ZAP**  
   - Has **DOM XSS scanning** in passive and active modes.  

🔹 **Google Chrome DevTools (DOM Breakpoints)**  
   - Set breakpoints on `document.write`, `innerHTML`, etc., to track execution.  

---

### **Final Summary**
| **Step** | **Action** |
|----------|-----------|
| **1️⃣ Find User Input** | Look for `location.search`, `document.URL`, `localStorage`, etc. |
| **2️⃣ Identify Sinks** | Check if input is inserted via `document.write()`, `innerHTML`, `eval()`, etc. |
| **3️⃣ Test Payloads** | Inject `<script>alert('XSS')</script>` and observe execution. |
| **4️⃣ Use DevTools** | Check JavaScript execution and DOM changes. |
| **5️⃣ Use Security Tools** | Try **Burp Suite**, **OWASP ZAP**, and browser extensions. |


---


Let's break down each component in your code to **fully understand how it leads to DOM-based XSS**.  

---

## **Code Breakdown:**
```javascript
function doSearchQuery(query) {
    document.getElementById('searchMessage').innerHTML = query;
}

var query = (new URLSearchParams(window.location.search)).get('search');

if (query) {
    doSearchQuery(query);
}
```

---

### **1️⃣ `window.location.search` (User Input Source)**
```javascript
window.location.search
```
- This retrieves everything after the `?` in the URL.  
- Example: If the URL is:
  ```
  https://victim.com/page?search=hello
  ```
  Then:
  ```javascript
  console.log(window.location.search); // Output: "?search=hello"
  ```

- **This means the attacker can control `search` by modifying the URL**.

---

## **Summary Table**
| Component | Purpose | Security Issue |
|-----------|---------|---------------|
| `window.location.search` | Retrieves user input from the URL | Attacker can modify it |
| `new URLSearchParams().get('search')` | Extracts `search` value | Extracted value can contain JavaScript |
| `document.getElementById('searchMessage')` | Selects an HTML element | Target where attacker injects code |
| `innerHTML` | Inserts `query` into the page | Executes JavaScript if input contains scripts |
| **Fix** | `textContent` or **sanitize input** | Prevents execution of malicious code |

---
