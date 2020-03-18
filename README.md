![Docker Image CI](https://github.com/bateau84/openttd/workflows/Docker%20Image%20CI/badge.svg?branch=master)

## Usage ##

### envs ###

| Env | Default | Meaning |
| --- | ------- | ------- |
| savepath | "/home/openttd/.openttd/save" | The path to which autosave wil save |
| loadgame | `null` | load game has 4 settings. false, true, last-autosave and exit.<br>  - false: this will just start server and create a new game.<br>  - true: if true is set you also need to set savename. savename needs to be the name of the saved game file. This will load the given saved game.<br>  - last-autosave: This will load the last autosaved game located in <$savepath>/autosave folder.<br>  - exit: This will load the exit.sav file located in <$savepath>/autosave/. |
| savename | `null` | Set this when allong with `loadgame=true` to the value of your save game file-name |
| PUID | "911" | This is the ID of the user inside the container. If you mount in (-v </path/of/your/choosing>:</path/inside/container>) you would need for the user inside the container to have the same ID as your user outside (so that you can save files for example). |
| PGID | "911" | Same thing here, except Group ID. Your user has a group, and it needs to map to the same ID inside the container. |
| debug | `null` | Set debug things. see openttd for debug options |


### Examples ###

    docker run -d -p 3979:3979/tcp -p 3979:3979/udp bateau/openttd:latest

For random port assignment replace

    -p 3979:3979/tcp -p 3979:3979/udp

with 

    -P

Its set up to not load any games by default (new game) and it can be run without mounting a .openttd folder. 
However, if you want to save/load your games, mounting a .openttd folder is required.

Set UID and GID of user in container to be the same as your user outside with seting env PUID and PGID.
For example

    -e PUID=1000 -e PGID=1000

For other save games use (/home/openttd/.openttd/save/ is appended to savename when passed to openttd command)

    -e "loadgame=true" -e "savename=game.sav"

Config files is located under /home/openttd/.openttd. To mount up your .openttd folder use 

   -v /path/to/your/.openttd:/home/openttd/.openttd

For example to run server and load my savename game.sav:

    docker run -d --name openttd -p 3979:3979/tcp -p 3979:3979/udp -v /home/<your_username>/.openttd:/home/openttd/.openttd -e PUID=<your_userid> -e PGID=<your_groupid> -e "loadgame=true" -e "savename=game.sav" bateau/openttd:latest

## Kubernetes ##

Supplied some example for deploying on kubernetes cluster. "openttd.yaml"
just run 

    kubectl apply openttd.yaml

and it will apply configmap with openttd.cfg, deployment and service listening on port 31979 UDP/TCP.

## Other tags ##
   * See [bateau/openttd](https://hub.docker.com/r/bateau/openttd) on docker hub for other tags
