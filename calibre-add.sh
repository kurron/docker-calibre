#!/bin/bash

CMD="docker run \
       --rm \
       --name calibre-import \
       --net "host" \
       --user 1000:1000 \
       --volume $HOME:/home/developer \
       --volume $HOME/library:/library \
       --volume $HOME/import:/import:ro \
       -it \
       --entrypoint '/bin/bash' \
       kurron/docker-calibre:latest" 

#      --entrypoint '/usr/bin/xvfb-run /usr/bin/calibredb add /import/Head_First_Python_Second_Edition.epub --library-path /library' \
echo $CMD
eval $CMD
