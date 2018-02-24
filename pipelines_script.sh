#!/usr/bin/env bash

RUN_PIPELINE_CMD="${RUN_PIPELINE_CMD:-dpp run}"

RES=0;


if [ "${1}" == "--dump-to-db" ]; then
    DB_USER="${DB_USER:-oknesset}"
    DB_HOST="${DB_HOST:-localhost}"
    DB_PORT="${DB_PORT:-5432}"
    DB_NAME="${DB_NAME:-oknesset}"
    ( [ -z "DB_USER" ] || [ -z "DB_PASS" ] || [ -z "DB_HOST" ] || [ -z "DB_PORT" ] || [ -z "DB_NAME" ] ) \
        && echo "missing required env vars" && exit 1
    export

    ! dpp run ./join-maya-directors && echo failed to join maya directors && RES=1
    ! DPP_DB_ENGINE="postgresql://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_NAME}" dpp run ./dump-maya-directors-to-db \
        && echo "failed to dump to db" && RES=1

    ! PGPASSWORD="${DB_PASS}" psql -h $DB_HOST -U $DB_USER -p $DB_PORT -d $DB_NAME -c "
        grant select on maya_directors to redash_reader;
    " && echo "failed to grant permissions to redash" && RES=1
    echo Great Success!

fi

exit $RES
