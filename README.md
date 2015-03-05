## Usage ##

    docer run -d --name="openttd" -p 3979:3979/tcp -p 3979:3979/udp -v /path/to/your/user/.openttd:/home/openttd/.openttd/ bateau/openttd:latest

Openttd runs version 1.4.4.
Its set up to not load any games by default (new game). 
Set -e "loadgame=true" to enable loading of exit.sav. For other save games use -e "loadgame=true" -e "savename=save/game.sav".

## Other tags ##
   * 1.4.4
   * 1.5.0-beta2
   * 1.5.0-beta1
