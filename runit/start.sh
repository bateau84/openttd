#!/bin/sh

savegame=save/$savename

# Loads the desired game, or prepare to load it next time server starts up!
if [ -n $loadgame ]; then

        case "$loadgame" in
                'true')
                        if [ -f  /usr/share/games/openttd/$savename ]; then
                                echo "We are loading a save game!"
                                echo "Lets load $savename"
                                exec $screen /usr/games/openttd -D -g $savegame -x
                                exit 0
                        else
                                echo "$savegame not found..."
                                exit 0
                        fi
                ;;
                'false')
                        echo "Creating a new game."
                        exec $screen /usr/games/openttd -D -x
                        exit 0
                ;;
                'exit')
                        echo "Loading last exit.sav game"
                        exec $screen /usr/games/openttd -D -g /save/autosave/exit.sav -x
                        exit 0
                ;;
        esac
else
        echo "$loadgame not set, starting new game"
        exec $screen /usr/games/openttd -D -x
        exit 0
fi

function shutdown {
  # There are no more loopback devices available.
  # Shutting down daemon due to errors: error intializing graphdriver: loopback mounting failed
  echo "Shuting down openttd..."
  kill -3 `ps ax | grep "openttd" | grep -v grep | awk {'print $1'}`
}

trap shutdown SIGINT SIGKILL SIGEXIT SIGHUP SIGPIPE SIGTERM SIGUSR1 SIGUSR2
