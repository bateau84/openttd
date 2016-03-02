#!/bin/bash
PUID=${PUID:-911}
PGID=${PGID:-911}
PHOME=${PHOME:-"/home/openttd"}

if [ ! "$(id -u openttd)" -eq "$PUID" ]; then usermod -o -u "$PUID" openttd ; fi
if [ ! "$(id -g openttd)" -eq "$PGID" ]; then groupmod -o -g "$PGID" openttd ; fi
if [ ! "$(grep openttd /etc/passwd | cut -d':' -f6)" == ${PHOME} ]; then
        if [ ! -d ${PHOME} ]; then
                mkdir -p ${PHOME}
                chown openttd:openttd ${PHOME}
        fi
        usermod -m -d ${PHOME} openttd
fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u openttd)
User gid:    $(id -g openttd)
User Home:   $(grep openttd /etc/passwd | cut -d':' -f6)
-----------------------------------
"
