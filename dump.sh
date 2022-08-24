#!/usr/bin/env bash

set -ex

: ${POC_NETWORK:="keycloak-poc_default"}
: ${POC_PGUSER:="postgres"}
: ${POC_PGHOST:="postgres"}
: ${POC_PGDBNAME:="keycloak_poc"}

docker run --rm -it \
    -v $(pwd):/data \
    --network ${POC_NETWORK} \
    postgres:10-bullseye \
    /bin/bash -c "pg_dump -U ${POC_PGUSER} -h ${POC_PGHOST} -C ${POC_PGDBNAME} > /data/${POC_PGDBNAME}.sql"
