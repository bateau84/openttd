#!/bin/bash
#set -e
#set -x

USER=${USER:-"abc"}
PUID=${PUID:-1000}
PGID=${PGID:-1000}
PAGID=${PAGID:-0}
PHOME=${PHOME:-"/home/${USER}"}

# Change UID of user
if [ ! "$(id -u ${USER})" -eq "${PUID}" ]; then
	sed -i -r 's/^('${USER}':.*:)\d{1,5}(:\d{1,5}:.*)$/\1'${PUID}'\2/g' /etc/passwd
fi

# Change GID of user 
if [ ! "$(id -g ${USER})" -eq "${PGID}" ]; then
	sed -i -r 's/^('${USER}':.*:\d{1,5}:)\d{1,5}(:.*)$/\1'${PGID}'\2/g' /etc/passwd
	sed -i -r 's/^('${USER}':.*:)\d{1,6}(:.*)$/\1'${PGID}'\2/g' /etc/group
fi

# Add additional group to user if supplied
if [ ! "${PAGID}" -eq "0" ]; then
	addgroup -g ${PAGID} additional || true
	addgroup ${USER} additional
fi

# Change home dir of user if supplied
if [ ! "$(grep ${USER} /etc/passwd | cut -d':' -f6)" == "${PHOME}" ]; then
	sed -i -r 's/^('${USER}':.*:\d{1,6}:\d{1,6}:.*:)\/.*(:.*)$/\1'${PHOME//\//\\\/}'\2/g' /etc/passwd
	if [ ! -d ${PHOME} ]; then
		mkdir -p ${PHOME}
	fi
	
	chown ${USER}:${USER} ${PHOME}
fi

# Print info
echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u ${USER})
User gid:    $(id -g ${USER})
User Home:   $(grep ${USER} /etc/passwd | cut -d':' -f6)
User info:   $(id ${USER})
-----------------------------------
"
