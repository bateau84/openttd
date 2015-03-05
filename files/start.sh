#/bin/bash
loadgame=${loadgame=false}
savename=${savename="save/autosave/exit.sav"}

if [[ $loadgame = true ]]; then
	echo "We are loading a save game!"
		echo "Lets load $savename"
		/usr/games/openttd -D -g "save/autosave/exit.sav" -x
else
	echo "Dont load game"
	/usr/games/openttd -D -x
fi
