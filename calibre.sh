#!/bin/bash

CMD="docker run \
       --rm \
       --name calibre-server \
       --net "host" \
       --user 1000:1000 \
       --volume $HOME:/home/developer \
       --volume $HOME/library:/library \
       --volume $HOME/import:/import \
       kurron/docker-calibre:latest"

echo $CMD
$CMD
