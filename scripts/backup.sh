#!/bin/bash

# -----------------------------------------------
# Inkrementální záloha z Windows (Cygwin) na Linux server
# Autor: Dominik Hoch
# -----------------------------------------------

# Nastavení PATH (kvůli příkazům v Cygwin)
PATH="/usr/local/bin:/usr/bin:/cygdrive/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/cygdrive/c/Windows/system32:/cygdrive/c/Windows:/cygdrive/c/Windows/System32/Wbem:/cygdrive/c/Windows/System32/WindowsPowerShell/v1.0:/cygdrive/c/Windows/System32/OpenSSH:/cygdrive/c/Program Files (x86)/Intel/Intel(R) Management Engine Components/DAL:/cygdrive/c/Program Files/Intel/Intel(R) Management Engine Components/DAL:/cygdrive/c/Program Files/Git/cmd:/cygdrive/c/Program Files (x86)/Microsoft SQL Server/160/Tools/Binn:/cygdrive/c/Program Files/Microsoft SQL Server/160/Tools/Binn:/cygdrive/c/Program Files/Microsoft SQL Server/Client SDK/ODBC/170/Tools/Binn:/cygdrive/c/Program Files/Microsoft SQL Server/160/DTS/Binn:/cygdrive/c/Users/NB/AppData/Local/Programs/Python/Python312/Scripts:/cygdrive/c/Users/NB/AppData/Local/Programs/Python/Python312:/cygdrive/c/Users/NB/AppData/Local/Microsoft/WindowsApps:/cygdrive/c/Users/NB/AppData/Local</Local/Programs/Microsoft VS Code/bin"

# Proměnné konfigurace
LOCAL_DIR="/cygdrive/c/Users/NB/Test/"           # Zdrojový adresář na Windows
REMOTE_DIR="/home/user/backups"                  # Cílový adresář na serveru
SSH_USER="jouda"                                 # SSH uživatel
SSH_HOST="dev.spsejecna.net"                     # SSH server
SSH_PORT="21041"                                 # SSH port
DATE=$(date +%Y-%m-%d)                           # Aktuální datum
INC_DIR="$REMOTE_DIR/inc-$DATE"                  # Adresář pro dnešní inkrementální zálohu

# Kontrola existence plné zálohy na serveru
echo "Kontroluji, zda existuje plná záloha..."
if ssh -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" "[ ! -d $REMOTE_DIR/full ]"; then
    echo "❌ Plná záloha neexistuje! Nejprve spusť full_backup.sh"
    exit 1
fi

# Vytvoření cílového adresáře pro inkrementální zálohu
echo "📁 Vytvářím adresář pro inkrementální zálohu: $INC_DIR"
ssh -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" "mkdir -p $INC_DIR"

# Spuštění rsync – porovnání s plnou zálohou a odeslání jen rozdílů
echo "Spouštím rsync (pouze nové/změněné soubory)..."
rsync -avzP \
    --compare-dest="$REMOTE_DIR/full/" \
    -e "ssh -p $SSH_PORT" \
    "$LOCAL_DIR" "$SSH_USER@$SSH_HOST:$INC_DIR/"

# ✅ Hotovo
echo "✅ Inkrementální záloha dokončena: $INC_DIR"
