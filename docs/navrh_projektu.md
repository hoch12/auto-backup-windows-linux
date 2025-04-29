# Návrh projektu – Automatická záloha Windows → Linux

## Autor
Dominik Hoch

C3b

Studijní obor: Informační technologie - Programování a digitální technologie

---

## # Anotace

Cílem práce je vytvořit jednoduchý systém pro automatickou zálohu souborů z operačního systému Windows na vzdálený Linux server. Pomocí nástroje `rsync` a prostředí Cygwin se zálohování provádí přes SSH, přičemž systém podporuje inkrementální i plné zálohy. Automatizace je řešena skripty a naplánovaným spouštěním pomocí Plánovače úloh (Task Scheduler) ve Windows.

---

## # Úvod

Zálohování dat je zásadní součástí IT bezpečnosti a správy systémů. I v domácím nebo školním prostředí může vést ztráta důležitých dokumentů ke ztrátě času nebo dat, která nelze obnovit. Cloudová řešení často vyžadují registraci, internetové připojení a někdy i měsíční poplatky.

Cílem tohoto projektu bylo vytvořit plně automatizovaný systém zálohování, který:

- není závislý na třetích stranách,
- je zdarma a open-source,
- funguje i offline v lokální síti.

Základem je jednoduchý skript v prostředí Cygwin, který pomocí `rsync` přes SSH přenáší soubory ze zvoleného adresáře na vzdálený server. Automatizace záloh je nastavena přes Windows Task Scheduler, který spouští skripty v daný čas (např. každý den ve 2:00 ráno).

---

## # Ekonomická rozvaha

### Konkurence

- Komerční zálohovací produkty (např. Acronis, EaseUS, Macrium)
- Cloudové služby (např. OneDrive, Google Drive, Dropbox, iCloud)

### Výhody projektu

- 100% zdarma (využití open-source nástrojů)
- Nezávislost na cloudovém připojení
- Nízké nároky na hardware a prostředí
- Možnost přizpůsobení pro školy nebo domácnosti

### Způsob propagace

- Veřejné GitHub repozitáře
- Reference a osobní doporučení

### Návratnost investice

Investice do projektu je nulová, veškeré nástroje jsou open-source. Návratnost je okamžitá, protože šetří čas a předchází ztrátě dat. Implementace netrvá více než 30 minut.

---

## # Vývoj

### Použité technologie

- Windows 10+ s nainstalovaným Cygwin
- Ubuntu Server (SSH)
- rsync
- bash
- Task Scheduler
- GitHub


### Průběh vývoje

1. Ověření funkčnosti rsync a SSH mezi Windows (Cygwin) a Linuxem
2. Vytvoření zálohovacích skriptů
3. Testování inkrementálních a plných záloh
4. Automatizace pomocí Task Scheduleru
5. Testování různých scénářů
6. Přidání dokumentace a GitHub integrace

---

## # Testování

### Přehled testovacích scénářů

| # | Scénář                                       | Očekávaný výsledek                                     | Výsledek |
|---|----------------------------------------------|--------------------------------------------------------|----------|
| 1 | Spuštění full_backup.sh ručně                | Vytvoření složky full-YYYY-MM-DD                       | OK       |
| 2 | Spuštění inc_backup.sh následující den       | Vytvoření složky inc-YYYY-MM-DD s novými soubory       | OK       |
| 3 | Spuštění restore.sh s datem                  | Obnovení zálohy odpovídajícího dne                     | OK       |
| 4 | Spuštění s vypnutým serverem                 | Chybová hláška a přerušení procesu                     | OK       |
| 5 | Spuštění ze Správce úloh ve Windows          | Skript běží bez ručního zásahu                         | OK       |

---

## # Nasazení

### Požadavky

- Cygwin s balíčky: bash, rsync, openssh
- SSH přístup na Linux server
- Správně nastavené SSH klíče nebo `sshpass`
- Windows Task Scheduler

### Postup instalace a spuštění

1. Instalace Cygwin + potřebné balíčky
2. Naklonování GitHub repozitáře
3. Úprava proměnných ve skriptech (např. `LOCAL_DIR`, `REMOTE_DIR`)
4. Vytvoření SSH připojení
5. Nastavení plánovače úloh ve Windows:
   - inkrementální záloha: denně ve 2:00
   - full záloha: každou neděli ve 3:00

---

## # Licence

Projekt je licencí **MIT**.

Uživatelé mohou:

- kopírovat, upravovat a distribuovat kód,
- používat řešení pro osobní i komerční účely,
- nejsou povinni platit ani citovat autora, ale ocení se to.

---

## # GitHub repozitář

https://github.com/hoch12/auto-backup-windows-linux

---

## # Závěr

Projekt splnil zadání vytvořit jednoduchý, bezpečný a funkční systém zálohování bez závislosti na komerčním softwaru nebo cloudu. Záloha funguje zcela automaticky na pozadí, aniž by rušila uživatele.

Řešení je snadno přizpůsobitelné i pro jiné účely, jako jsou školní počítače, domácí servery nebo studentské notebooky. Vývoj projektu umožnil hlubší pochopení práce s Cygwinem, rsyncem, SSH a automatizací ve Windows. Zároveň slouží jako přenositelný open-source nástroj, který může použít kdokoliv zdarma.



