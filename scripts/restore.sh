#!/bin/bash

# -----------------------------------------------
# Obnovení inkrementální zálohy
# Autor: Dominik Hoch
# -----------------------------------------------

# Nastavení PATH (kvůli příkazům v Cygwin)
PATH="/usr/local/bin:/usr/bin:/cygdrive/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/cygdrive/c/Windows/system32:/cygdrive/c/Windows:/cygdrive/c/Windows/System32/Wbem:/cygdrive/c/Windows/System32/WindowsPowerShell/v1.0:/cygdrive/c/Windows/System32/OpenSSH:/cygdrive/c/Program Files (x86)/Intel/Intel(R) Management Engine Components/DAL:/cygdrive/c/Program Files/Intel/Intel(R) Management Engine Components/DAL:/cygdrive/c/Program Files/Git/cmd:/cygdrive/c/Program Files (x86)/Microsoft SQL Server/160/Tools/Binn:/cygdrive/c/Program Files/Microsoft SQL Server/160/Tools/Binn:/cygdrive/c/Program Files/Microsoft SQL Server/Client SDK/ODBC/170/Tools/Binn:/cygdrive/c/Program Files/Microsoft SQL Server/160/DTS/Binn:/cygdrive/c/Users/NB/AppData/Local/Programs/Python/Python312/Scripts:/cygdrive/c/Users/NB/AppData/Local/Programs/Python/Python312:/cygdrive/c/Users/NB/AppData/Local/Microsoft/WindowsApps:/cygdrive/c/Users/NB/AppData/Local</Local/Programs/Microsoft VS Code/bin"


# Proměnnékon figurace
REMOTE_DIR="/home/user/backups"                         # Cesta k zálohám na serveru
SSH_USER="jouda"                                        # SSH uživatel
SSH_HOST="dev.spsejecna.net"                            # SSH server
SSH_PORT="21041"                                        # SSH port
LOCAL_RESTORE_DIR="/cygdrive/c/Users/NB/Test-Restore/"  # Kam obnovit na Windows
DATE=$1                                                 # Datum inkrementální zálohy, např. "2025-04-04"

# Ověření vstupu
if [ -z "$DATE" ]; then
  echo "Chyba: Musíš zadat datum inkrementální zálohy (např. 2024-04-04)."
  exit 1
fi

echo "==============================="
echo "Obnova záloh z plné zálohy + změny k datu: $DATE"
echo "==============================="

# 1. Obnova plné zálohy
echo "Obnovuji plnou zálohu..."
rsync -avzP -e "ssh -p $SSH_PORT" $SSH_USER@$SSH_HOST:$REMOTE_DIR/full/ $LOCAL_RESTORE_DIR

# 2. Obnova rozdílných souborů z inkrementální zálohy
echo "Obnovuji změny z inkrementální zálohy $DATE..."
rsync -avzP --link-dest=$REMOTE_DIR/full/ -e "ssh -p $SSH_PORT" $SSH_USER@$SSH_HOST:$REMOTE_DIR/inc-$DATE/ $LOCAL_RESTORE_DIR

# ✅ Hotovo
echo "Obnova dokončena!"
