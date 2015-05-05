#/bin/sh

# Loads the desired game, or prepare to load it next time server starts up!
if [ $loadgame = true && -f /usr/share/games/openttd/$savename ]; then
	echo "We are loading a save game!"
	echo "Lets load $savename"
	screen -S /usr/games/openttd -D -g $savename -x
else
# If game is not found, it creates a new game
	echo "Creating a new game. (If you spesified a game to load, we did not find it...)"
	screen -S openttd /usr/games/openttd -D -x
fi
