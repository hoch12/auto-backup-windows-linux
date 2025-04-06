#!/bin/bash

# -----------------------------------------------
# Plná záloha z Windows (Cygwin) na Linux server
# Autor: Dominik Hoch
# -----------------------------------------------

# Nastavení PATH (pro píkazy v Cygwin)
PATH="/usr/local/bin:/usr/bin:/cygdrive/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/cygdrive/c/Windows/system32:/cygdrive/c/Windows:/cygdrive/c/Windows/System32/Wbem:/"

# Proměnné konfigurace
LOCAL_DIR="/cygdrive/c/Users/NB/Test/"           # Zdrojový adresář (Windows)
REMOTE_DIR="/home/user/backups"                  # Cílový adresář (Linux server)
SSH_USER="jouda"
SSH_HOST="dev.spsejecna.net"
SSH_PORT="21041"
DATE=$(date +%Y-%m-%d)
FULL_DIR="$REMOTE_DIR/full-$DATE"                # Např. /home/user/backups/full-2025-03-16

#️ Vytvoření nové plné zálohy
echo "📦 Vytvářím novou plnou zálohu: $FULL_DIR"
rsync -avzP -e "ssh -p $SSH_PORT" "$LOCAL_DIR" "$SSH_USER@$SSH_HOST:$FULL_DIR/"

#️ Odstranění předchozí zálohy "full" (pokud existuje)
echo "🧹 Odstraňuji předchozí zálohu: $REMOTE_DIR/full"
ssh -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" "rm -rf $REMOTE_DIR/full"

# Přesun nové zálohy na místo `full`
echo "📁 Přesouvám $FULL_DIR → $REMOTE_DIR/full"
ssh -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" "mv $FULL_DIR $REMOTE_DIR/full"

# ✅ Hotovo
echo "✅ Plná záloha dokončena na serveru: $REMOTE_DIR/full"

sleep 3
