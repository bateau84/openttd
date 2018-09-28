These images have been built and tested on docker 18.06.1-ce. Previous versions may not run as smooth.

## Usage ##

    docker run -d -p 3979:3979/tcp -p 3979:3979/udp bateau/openttd:latest

For random port assignment replace

    -p 3979:3979/tcp -p 3979:3979/udp

with 

    -P

Its set up to not load any games by default (new game) and it can be run without mounting a .openttd folder. 
However, if you want to load your savegames, mounting a .openttd folder is required.

loadgame has 4 "modes". true, false, last-autosave and exit.
By setting `-e loadgame=true` you allso need to supply the name of the savegame by passing `-e savegame=<your-save-game>`. 
With `-e loadgame=last-autosave` it will take the last (by timestamp) file created in autosave folder and load it.
With `-e loadgame=exit` it will load the game in autosave called exit.sav. to enable Openttd to save on exit you need to set "autosave_on_exit = true" in your openttd.cfg file under the [gui] section.

Set UID and GID of user in container to be the same as your user outside with seting env PUID and PGID.
For example

    -e PUID=1001 -e PGID=1000

For other save games use (/home/openttd/.openttd/save/ is appended to savename when passed to openttd command)

    -e "loadgame=true" -e "savename=game.sav"

Config files is located under /home/openttd/.openttd. To mount up your .openttd folder use 

   -v /path/to/your/.openttd:/home/openttd/.openttd

For example to run server and load my savename game.sav:

    docker run -d --name openttd -p 3979:3979/tcp -p 3979:3979/udp -v /home/<your_username>/.openttd:/home/openttd/.openttd -e PUID=<your_userid> -e PGID=<your_groupid> -e "loadgame=true" -e "savename=game.sav" bateau/openttd:latest

## Other tags ##
   * 1.8.0
   * 1.8.0-RC1
   * 1.7.2
   * 1.7.2-RC1
   * 1.7.1
   * 1.7.1-RC1
   * 1.7.0
   * 1.6.1
   * 1.6.1-RC1
   * 1.5.3
   * 1.5.2
   * 1.5.1
   * 1.5.0
   * 1.4.4
   * 1.5.0-rc1
   * 1.5.0-beta2
   * 1.5.0-beta1
