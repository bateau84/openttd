## Usage ##

    docer run -d --name="openttd" -p 3979:3979/tcp -p 3979:3979/udp -v /path/to/your/user/.openttd:/home/openttd/.openttd/ bateau/openttd

Openttd runs version 1.4.4.
Its set up to load exit.sav on start.
New game will be started on failure to load exit.sav.

## Other tags ##
   * 1.4.4
   * 1.5.0-beta1
