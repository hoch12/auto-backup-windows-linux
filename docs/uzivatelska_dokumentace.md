# Uživatelská dokumentace

## 📦 Požadavky
- Windows 10+
- Nainstalovaný Cygwin s balíčky: `rsync`, `openssh`, `wget`, `nano` (volitelně)
- Linux server s SSH přístupem
- GitHub účet

## 🧰 Instalace Cygwin
1. Stáhni `setup-x86_64.exe` z [https://cygwin.com](https://cygwin.com)
2. Nainstaluj a vyber tyto balíčky:
   - `rsync`
   - `openssh`
   - `wget`
   - `nano` (nebo použij `vim`)

## 🔑 Nastavení SSH přístupu
1. Generuj SSH klíč v Cygwin
``` ssh-keygen ```

Nahraj veřejný klíč na server:


```ssh-copy-id -p PORT user@server ```
(pokud ssh-copy-id nefunguje, použij ručně přes cat ```~/.ssh/id_rsa.pub``` a vlož do ```~/.ssh/authorized_keys``` na serveru)

## 📁 Struktura záloh
/home/user/backups/

├── full_YYYY-MM-DD/

└── inc_YYYY-MM-DD/

## 🗂️ Skripty
full_backup.sh – vytvoří novou full zálohu

backup.sh – vytvoří inkrementální zálohu na základě full zálohy

restore.sh – obnoví zálohu z vybraného dne

## 🛠️ Spuštění skriptů
```full_backup.sh ```
```inc_backup.sh ```
```restore.sh YYYY-MM-DD ```

## 📅 Automatizace
Pomocí Task Scheduleru ve Windows:

Spouštěj inc_backup.sh denně ve 2:00

Spouštěj full_backup.sh 1x týdně (např. neděle)

⚙️ Task Scheduler – Nastavení
Otevři Task Scheduler → Create Task

Trigger: Daily / Weekly

Action: Start a program → C:\cygwin64\bin\bash.exe

Argument: -l -c '/path/to/script/backup.sh'

(přizpůsob cestu podle tvého umístění skriptů)

## 🧪 Testování
Po instalaci spusť zálohování ručně a zkontroluj:

Zda se data správně kopírují

Že inkrementální záloha obsahuje jen nové soubory

## 💬 Tipy
Pokud nechceš používat SSH klíče, můžeš využít sshpass

Vždy zkontroluj, že server je online a přístupný na daném portu
