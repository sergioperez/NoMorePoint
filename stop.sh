#!/usr/bin/bash
CONT_ID_FILE="${PWD}/.container_id"
CONT_ID=$(cat ${CONT_ID_FILE})
podman kill ${CONT_ID}
podman rm ${CONT_ID}
rm ${CONT_ID_FILE}
