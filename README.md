![Docker Image CI](https://github.com/bateau84/openttd/workflows/Docker%20Image%20CI/badge.svg?branch=master)  
[![dockeri.co](https://dockeri.co/image/bateau/openttd)](https://hub.docker.com/r/bateau/openttd)
## Usage ##

### File locations ###
This image is supplied with a user named `openttd`.  
Openttd server is run as this user and subsequently its home folder will be `/home/openttd`.  
Openttd on linux uses `.openttd` in the users homefolder to store configurations, savefiles and other miscellaneous files.  
If you want to your local files accessible to openttd server inside the container you need to mount them inside with `-v` parameter (see https://docs.docker.com/engine/reference/commandline/run/ for more details on -v)


### Environment variables ###
These environment variables can be altered to change the behavior of the application inside the container.  
To set a new value to an enviroment variable use docker's `-e ` parameter (see https://docs.docker.com/engine/reference/commandline/run/ for more details)  

| Env | Default | Meaning |
| --- | ------- | ------- |
| savepath | "/home/openttd/.openttd/save" | The path to which autosave wil save |
| loadgame | `null` | load game has 4 settings. false, true, last-autosave and exit.<br>  - **false**: this will just start server and create a new game.<br>  - **true**: if true is set you also need to set savename. savename needs to be the name of the saved game file. This will load the given saved game.<br>  - **last-autosave**: This will load the last autosaved game located in <$savepath>/autosave folder.<br>  - **exit**: This will load the exit.sav file located in <$savepath>/autosave/. |
| savename | `null` | Set this when allong with `loadgame=true` to the value of your save game file-name |
| PUID | "911" | This is the ID of the user inside the container. If you mount in (-v </path/of/your/choosing>:</path/inside/container>) you would need for the user inside the container to have the same ID as your user outside (so that you can save files for example). |
| PGID | "911" | Same thing here, except Group ID. Your user has a group, and it needs to map to the same ID inside the container. |
| debug | `null` | Set debug things. see openttd for debug options |


### Networking ###
By default docker does not expose the containers on your network. This must be done manually with `-p` parameter (see [here](https://docs.docker.com/engine/reference/commandline/run/) for more details on -p).
If your openttd config is set up to listen on port 3979 you need to map the container port to your machines network like so `-p 3979:3979` where the first reference is the host machines port and the second the container port.

### Examples ###

Run Openttd and expose the default ports.  

    docker run -d -p 3979:3979/tcp -p 3979:3979/udp bateau/openttd:latest

Run Openttd with random port assignment.  

    docker run -d -P bateau/openttd:latest

Its set up to not load any games by default (new game) and it can be run without mounting a .openttd folder.  
However, if you want to save/load your games, mounting a .openttd folder is required.

    docker run -v /path/to/your/.openttd:/home/openttd/.openttd -p 3979:3979/tcp -p 3979:3979/udp bateau/openttd:latest

Set UID and GID of user in container to be the same as your user outside with seting env PUID and PGID.
For example

    docker run -e PUID=1000 -e PGID=1000 -v /path/to/your/.openttd:/home/openttd/.openttd -p 3979:3979/tcp -p 3979:3979/udp bateau/openttd:latest

For other save games use (/home/openttd/.openttd/save/ is appended to savename when passed to openttd command)

    docker run -e "loadgame=true" -e "savename=game.sav" -v /path/to/your/.openttd:/home/openttd/.openttd -p 3979:3979/tcp -p 3979:3979/udp bateau/openttd:latest

For example to run server and load my savename game.sav:

    docker run -d -p 3979:3979/tcp -p 3979:3979/udp -v /home/<your_username>/.openttd:/home/openttd/.openttd -e PUID=<your_userid> -e PGID=<your_groupid> -e "loadgame=true" -e "savename=game.sav" bateau/openttd:latest

## Kubernetes ##

Supplied some example for deploying on kubernetes cluster. "k8s_openttd.yml"
just run 

    kubectl apply openttd.yaml

and it will apply configmap with openttd.cfg, deployment and service listening on port 31979 UDP/TCP.

## Other tags ##
   * See [bateau/openttd](https://hub.docker.com/r/bateau/openttd) on docker hub for other tags
