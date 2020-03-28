#!/usr/bin/bash

trap stop_container INT

function stop_container() {
  ./stop.sh
  exit
}

CONT_ID_FILE="${PWD}/.container_id"
if [[ -f "${CONT_ID_FILE}" ]]
then
  stop_container
fi

export SLIDES_PORT=8123
export STATUS_PORT=8124
 
podman run --cidfile "$PWD/.container_id" -p ${SLIDES_PORT}:${SLIDES_PORT} -p ${STATUS_PORT}:${STATUS_PORT} -v $(pwd)/slides:/opt/slides/src:Z slider & 

sleep 1.5
xdg-open "http://localhost:${SLIDES_PORT}"

while true
do
  echo "Press control-c to exit"
  sleep 3600
done
