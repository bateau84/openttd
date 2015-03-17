These images have been built and tested on docker 1.5.0. Previous versions may not run as smooth.

## Usage ##

    docker run -d -p 3979:3979/tcp -p 3979:3979/udp bateau/openttd:latest

For random port assignment replace

    -p 3979:3979/tcp -p 3979:3979/udp

with 

    -P

Its set up to not load any games by default (new game) and it can be run without mounting a .openttd folder. however, if you want to load your savegames, this is required.

Set 

    -e "loadgame=true" 

to enable loading of save/autosave/exit.sav. 

For other save games use 

    -e "loadgame=true" -e "savename=your/save/game.sav"

To mount up your .openttd folder use 

   -v /path/to/your/.openttd:/root/.openttd

For example to run server and load my savegame game.sav:

    docker run -d --name openttd -p 3979:3979/tcp -p 3979:3979/udp -v /home/username/.openttd:/root/.openttd -e "loadgame=true" -e "savename=save/game.sav" bateau/openttd:latest

## Other tags ##
   * 1.4.4
   * 1.5.0-beta2
   * 1.5.0-beta1
