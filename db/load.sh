#!/bin/sh

BASE_DIR=$(dirname $(readlink -f "$0"))
if [ "$1" != "test" ]
then
    psql -h localhost -U pajaritos -d pajaritos < $BASE_DIR/pajaritos.sql
fi
psql -h localhost -U pajaritos -d pajaritos_test < $BASE_DIR/pajaritos.sql
