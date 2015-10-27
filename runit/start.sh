#!/bin/sh

savepath="/home/openttd/.openttd/save"
savegame="${savepath}/${savename}"
LOADGAME_CHECK="${loadgame}x"

# Loads the desired game, or prepare to load it next time server starts up!
if [ ${LOADGAME_CHECK} != "x" ]; then

        case ${loadgame} in
                'true')
                        if [ -f  ${savegame} ]; then
                                echo "We are loading a save game!"
                                echo "Lets load ${savegame}"
                                exec /sbin/setuser openttd /usr/games/openttd -D -g ${savegame} -x -d ${DEBUG}
                                exit 0
                        else
                                echo "${savegame} not found..."
                                exit 0
                        fi
                ;;
                'false')
                        echo "Creating a new game."
                        exec /sbin/setuser openttd /usr/games/openttd -D -x -d ${DEBUG}
                        exit 0
                ;;
                'exit')

			savegame="${savepath}/autosave/exit.sav"

			if [ -r ${savegame} ]; then
	                        echo "Loading ${savegame}"
        	                exec /sbin/setuser openttd /usr/games/openttd -D -g ${savegame} -x -d ${DEBUG}
                	        exit 0
			else
				echo "${savegame} not found..."
				exit 1
			fi
                ;;
		*)
			echo "ambigous loadgame (\"${loadgame}\") statement inserted."
			exit 1
		;;
        esac
else
	echo "\$loadgame (\"${loadgame}\") not set, starting new game"
        exec /sbin/setuser openttd /usr/games/openttd -D -x
        exit 0
fi
