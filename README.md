These images have been built and tested on docker 1.7.1. Previous versions may not run as smooth.

## Usage ##

    docker run -d -p 3979:3979/tcp -p 3979:3979/udp bateau/openttd:latest

For random port assignment replace

    -p 3979:3979/tcp -p 3979:3979/udp

with 

    -P

Its set up to not load any games by default (new game) and it can be run without mounting a .openttd folder. 
However, if you want to load your savegames, mounting a .openttd folder is required.

Set 

    -e "loadgame=exit" 

to enable loading of save/autosave/exit.sav.
For Openttd to save on exit you need to set "autosave_on_exit = true" in your openttd.cfg file under the [gui] section.

Set UID og GID of user in container to be the same as your user outside with seting env PUID and PGID.
For example

    -e PUID=1001 -e PGID=1000

For other save games use 

    -e "loadgame=true" -e "savename=your/save/game.sav"

To mount up your .openttd folder use 

   -v /path/to/your/.openttd:/root/.openttd

For example to run server and load my savegame game.sav:

    docker run -d --name openttd -p 3979:3979/tcp -p 3979:3979/udp -v /home/username/.openttd:/root/.openttd -e PUID=1001 -e PGID=1000 -e "loadgame=true" -e "savename=game.sav" bateau/openttd:latest

## Other tags ##
   * 1.5.2
   * 1.5.1
   * 1.5.0
   * 1.4.4
   * 1.5.0-rc1
   * 1.5.0-beta2
   * 1.5.0-beta1
