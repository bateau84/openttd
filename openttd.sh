#!/bin/sh

savepath="/home/openttd/.openttd/save"
savegame="${savepath}/${savename}"
LOADGAME_CHECK="${loadgame}x"
loadgame=${loadgame:-'false'}
ottdlocation="/home/openttd/gamefiles/openttd-13.0-linux-generic-amd64/openttd"

PUID=${PUID:-911}
PGID=${PGID:-911}
PHOME=${PHOME:-"/home/openttd"}
USER=${USER:-"openttd"}

if [ ! "$(id -u ${USER})" -eq "$PUID" ]; then usermod -o -u "$PUID" ${USER} ; fi
if [ ! "$(id -g ${USER})" -eq "$PGID" ]; then groupmod -o -g "$PGID" ${USER} ; fi
if [ "$(grep ${USER} /etc/passwd | cut -d':' -f6)" != "${PHOME}" ]; then
        if [ ! -d ${PHOME} ]; then
                mkdir -p ${PHOME}
                chown ${USER}:${USER} ${PHOME}
        fi
        usermod -m -d ${PHOME} ${USER}
fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u ${USER})
User gid:    $(id -g ${USER})
User Home:   $(grep ${USER} /etc/passwd | cut -d':' -f6)
-----------------------------------
"

# Loads the desired game, or prepare to load it next time server starts up!
if [ ${LOADGAME_CHECK} != "x" ]; then

        case ${loadgame} in
                'true')
                        if [ -f  ${savegame} ]; then
                                echo "We are loading a save game!"
                                echo "Lets load ${savegame}"
                                su -l openttd -c ${ottdlocation} -D -g ${savegame} -x -d ${DEBUG}"
                                exit 0
                        else
                                echo "${savegame} not found..."
                                exit 0
                        fi
                ;;
                'false')
                        echo "Creating a new game."
                        su -l openttd -c "${ottdlocation} -D -x -d ${DEBUG}"
                        exit 0
                ;;
                'last-autosave')

			savegame=${savepath}/autosave/`ls -rt ${savepath}/autosave/ | tail -n1`

			if [ -r ${savegame} ]; then
	                        echo "Loading ${savegame}"
        	                su -l openttd -c "${ottdlocation} -D -g ${savegame} -x -d ${DEBUG}"
                	        exit 0
			else
				echo "${savegame} not found..."
	                        echo "Creating a new game."
	                        su -l openttd -c "${ottdlocation} -D -x -d ${DEBUG}"
	                        exit 0
			fi
                ;;
                'exit')

			savegame="${savepath}/autosave/exit.sav"

			if [ -r ${savegame} ]; then
	                        echo "Loading ${savegame}"
        	                su -l openttd -c "${ottdlocation} -D -g ${savegame} -x -d ${DEBUG}"
                	        exit 0
			else
				echo "${savegame} not found..."
				echo "Creating a new game."
                        	su -l openttd -c "${ottdlocation} -D -x -d ${DEBUG}"
                        	exit 0
			fi
                ;;
		*)
			echo "ambigous loadgame (\"${loadgame}\") statement inserted."
			exit 1
		;;
        esac
else
	echo "\$loadgame (\"${loadgame}\") not set, starting new game"
        su -l openttd -c "${ottdlocation} -D -x"
        exit 0
fi
