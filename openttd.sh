#!/bin/sh

savepath="/home/openttd/.openttd/save"
savegame="${savepath}/${savename}"
LOADGAME_CHECK="${loadgame}x"
loadgame=${loadgame:-'false'}

# Loads the desired game, or prepare to load it next time server starts up!
if [ ${LOADGAME_CHECK} != "x" ]; then

        case ${loadgame} in
                'true')
                        if [ -f  ${savegame} ]; then
                                echo "We are loading a save game!"
                                echo "Lets load ${savegame}"
                                exec /usr/games/openttd -D -g ${savegame} -x -d ${DEBUG}
                                exit 0
                        else
                                echo "${savegame} not found..."
                                exit 0
                        fi
                ;;
                'false')
                        echo "Creating a new game."
                        exec /usr/games/openttd -D -x -d ${DEBUG}
                        exit 0
                ;;
                'last-autosave')

			savegame=${savepath}/autosave/`ls -rt ${savepath}/autosave/ | tail -n1`

			if [ -r ${savegame} ]; then
	                        echo "Loading ${savegame}"
        	                exec /usr/games/openttd -D -g ${savegame} -x -d ${DEBUG}
                	        exit 0
			else
				echo "${savegame} not found..."
				exit 1
			fi
                ;;
                'exit')

			savegame="${savepath}/autosave/exit.sav"

			if [ -r ${savegame} ]; then
	                        echo "Loading ${savegame}"
        	                exec /usr/games/openttd -D -g ${savegame} -x -d ${DEBUG}
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
        exec /usr/games/openttd -D -x
        exit 0
fi
