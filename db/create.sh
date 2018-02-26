#!/bin/sh

if [ "$1" = "travis" ]
then
    psql -U postgres -c "CREATE DATABASE pajaritos_test;"
    psql -U postgres -c "CREATE USER pajaritos PASSWORD 'pajaritos' SUPERUSER;"
else
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists pajaritos
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists pajaritos_test
    [ "$1" != "test" ] && sudo -u postgres dropuser --if-exists pajaritos
    sudo -u postgres psql -c "CREATE USER pajaritos PASSWORD 'pajaritos' SUPERUSER;"
    [ "$1" != "test" ] && sudo -u postgres createdb -O pajaritos pajaritos
    sudo -u postgres createdb -O pajaritos pajaritos_test
    LINE="localhost:5432:*:pajaritos:pajaritos"
    FILE=~/.pgpass
    if [ ! -f $FILE ]
    then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE
    then
        echo "$LINE" >> $FILE
    fi
fi
