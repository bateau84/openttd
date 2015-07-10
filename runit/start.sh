#!/bin/sh

savepath=/root/.openttd/save
savegame=$savepath/$savename

# Loads the desired game, or prepare to load it next time server starts up!
if [ -n $loadgame ]; then

        case "$loadgame" in
                'true')
                        if [ -f  $savegame ]; then
                                echo "We are loading a save game!"
                                echo "Lets load $savegame"
                                exec /usr/games/openttd -D -g $savegame -x -d $DEBUG
                                exit 0
                        else
                                echo "$savegame not found..."
                                exit 0
                        fi
                ;;
                'false')
                        echo "Creating a new game."
                        exec /usr/games/openttd -D -x -d $DEBUG
                        exit 0
                ;;
                'exit')
			savegame=$savepath/autosave/exit.sav
                        echo "Loading $savegame"
                        exec /usr/games/openttd -D -g $savegame -x -d $DEBUG
                        exit 0
                ;;
        esac
else
        echo "\$loadgame not set, starting new game"
        exec /usr/games/openttd -D -x
        exit 0
fi
