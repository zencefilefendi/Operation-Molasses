# A.R.E.S. - Advanced Reconnaissance & Enumeration Scanner (v4.1 GOD MODE)

![ARES Scanner](https://img.shields.io/badge/Status-Active-success) ![Python](https://img.shields.io/badge/Python-3.8%2B-blue) ![Scapy](https://img.shields.io/badge/Scapy-Powered-red)

A.R.E.S., hedef sistemler ve yerel ağlar üzerinde derinlemesine bilgi toplamak (Reconnaissance) ve zafiyet tespiti öncesi yüzey haritalaması (Enumeration) yapmak için geliştirilmiş, **Multi-Threaded**, **Asenkron** ve **Stealth (Hayalet)** özelliklere sahip yeni nesil bir siber istihbarat aracıdır.

Sıradan port tarayıcıların aksine, güvenlik duvarlarını (Firewall) ve Saldırı Tespit/Engelleme Sistemlerini (IDS/IPS) atlatmak için özel "TCP SYN Half-Open" ve "Port Karıştırma (Randomize)" tekniklerini kullanır.

## 🔥 Öne Çıkan Özellikler (God Mode)

* **Multi-Thread Stealth SYN Taraması:** İşletim sisteminin TCP yığınını bypass ederek doğrudan ağ kartı üzerinden sahte `SYN` paketleri üretir. Firewall'ları atlatır ve hedefin loglarında minimum iz bırakır.
* **Asenkron TCP Connect (Turbo Mod):** Hedefi çok hızlı bir şekilde taramak için Python `asyncio` altyapısını kullanır. Ulimit kısıtlamalarını otomatik yönetir.
* **Akıllı Banner Grabbing:** Açık port tespit ettiğinde anında özel proplar (HTTP HEAD vb.) göndererek arkada çalışan servisin adını ve sürümünü (Fingerprinting) okur.
* **Pasif İşletim Sistemi Tespiti (OS Fingerprinting):** Hedefe doğrudan login olmadan, dönen paketlerin TTL (Time to Live) değerlerini analiz ederek sistemin Windows, Linux veya bir Cisco ağ cihazı olup olmadığını tespit eder.
* **IDS / IPS Atlatma (Evasion):** `--randomize` parametresi sayesinde portları sıralı değil, kaotik ve tamamen rastgele bir sırayla tarayarak yapay zeka destekli güvenlik duvarlarının radarına takılmaz.
* **Kör Nokta Taraması (UDP):** Genellikle unutulan ve kritik zafiyetler barındıran UDP portlarını tarayarak arka kapıları tespit eder.
* **Yerel Ağ İstihbaratı (ARP):** Bulunduğunuz yerel ağdaki (Wi-Fi/LAN) tüm cihazların IP adreslerini, gizli MAC adreslerini ve ağ kartı üreticisine bakarak "Cihaz Markalarını" saniyeler içinde haritalar.
* **Zengin Raporlama:** Siber güvenlik uzmanları için tüm bulguları operasyon sonrası `JSON` formatında kaydeder.

## ⚙️ Kurulum ve Gereksinimler

Aracın ham (raw) ağ paketleri üretebilmesi için `scapy` ve zengin terminal arayüzü için `rich` kütüphanesine ihtiyacı vardır.

```bash
# Gerekli kütüphaneleri yükleyin
pip3 install scapy rich

# Araca çalıştırma yetkisi verin
chmod +x ares_scanner.py
```

*Not: Stealth (SYN), UDP ve ARP modları, paket manipülasyonu yaptığı için **root (sudo)** yetkisi gerektirir.*

## 🚀 Kullanım Senaryoları (Playbook)

### 1. Standart Hızlı Tarama (Async Connect)
Hedefin en yaygın portlarını asenkron olarak çok yüksek hızda tarar. (Sudo gerektirmez).
```bash
python3 ares_scanner.py -t 192.168.1.10 -p 22,80,443,3389,8080
```

### 2. Güvenlik Duvarı Atlatma ve OS Tespiti (Stealth Mode)
Ping engelleyen veya standart port taramalarını (TCP Connect) bloklayan sistemleri TCP SYN paketleriyle gizlice tarar.
```bash
sudo python3 ares_scanner.py -t 3.1.3.1 -p 1-10000 --stealth --threads 200
```

### 3. IDS / IPS Şaşırtması (Randomize)
Güvenlik cihazlarının (Fortinet, Palo Alto vb.) port taramasını algılamaması için port sırasını rastgele karıştırır.
```bash
sudo python3 ares_scanner.py -t 3.1.3.1 -p 1-65535 --stealth --randomize --threads 500
```

### 4. UDP Kör Nokta Taraması
TCP yerine UDP portlarını hedef alır (DNS, SNMP, VPN vb.).
```bash
sudo python3 ares_scanner.py -t 10.10.10.5 -p 53,161,500 --udp
```

### 5. Yerel Ağ Haritalama (ARP Scan)
Bulunduğunuz ev veya şirket ağındaki tüm aktif cihazları, MAC adreslerini ve üretici markalarını (Apple, Samsung vb.) listeler.
```bash
sudo python3 ares_scanner.py -t 192.168.1.0/24 --arp
```

### 6. Raporlama
Operasyon sonuçlarını daha sonra incelemek için JSON olarak kaydeder.
```bash
sudo python3 ares_scanner.py -t 10.0.0.1 -p 1-1000 --stealth -o scan_report.json
```

## ⚠️ Yasal Uyarı

Bu araç, siber güvenlik uzmanlarının, sızma testi uzmanlarının (Pentesters) ve ağ yöneticilerinin kendi sistemlerini test etmeleri ve zafiyetlerini bulmaları amacıyla geliştirilmiştir. Yalnızca **izinli** ve **yetkiniz dahilindeki** sistemlerde kullanın. Kötüye kullanımından geliştirici sorumlu tutulamaz.
