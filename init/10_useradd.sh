#!/bin/bash
PUID=${PUID:-911}
PGID=${PGID:-911}

if [ ! "$(id -u openttd)" -eq "$PUID" ]; then usermod -o -u "$PUID" openttd ; fi
if [ ! "$(id -g openttd)" -eq "$PGID" ]; then groupmod -o -g "$PGID" openttd ; fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u openttd)
User gid:    $(id -g openttd)
-----------------------------------
"
