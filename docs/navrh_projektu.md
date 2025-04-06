# Návrh projektu – Automatická záloha Windows → Linux

## 1. Název projektu
**Automatická záloha mezi Windows a Linux pomocí Cygwin a rsync**

## 2. Cíl projektu
Cílem je vytvořit automatizovaný systém, který provádí pravidelné zálohování souborů z Windows (pomocí Cygwin) na Linuxový server přes SSH a rsync.

## 3. Motivace
Ztráta dat může být fatální – automatické zálohování chrání uživatele před náhodným smazáním, poškozením disku nebo ransomwarem. Cílem je vytvořit jednoduché, levné a přístupné řešení bez nutnosti třetí strany nebo cloudu.

## 4. Architektura systému
- **Zdrojový systém:** Windows 10+ s nainstalovaným Cygwin
- **Cíl:** Ubuntu server s SSH
- **Komunikace:** rsync přes SSH
- **Automatizace:** Windows Task Scheduler (nebo ručně)
- **Skriptovací jazyk:** Bash (v rámci Cygwin)

## 5. Funkce
- Inkrementální zálohování (denní)
- Full záloha (každých 7 dní)
- Obnova záloh z libovolného dne
- Zálohování pouze nových/změněných souborů

## 6. Použité nástroje a technologie
- rsync
- bash
- Cygwin
- Task Scheduler
- SSH/sshpass nebo klíče
- GitHub pro správu verzí a issues

## 7. Bezpečnost
- Možnost použití SSH klíče (bez zadávání hesla)
- Alternativa: sshpass (v omezeně bezpečném prostředí)
- Přenos probíhá přes šifrovaný SSH tunel
