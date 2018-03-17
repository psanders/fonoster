#!/usr/bin/env sh

bootstrap=/bootstrap

# Unrestricted while creating user
mongod --config /etc/mongod.conf; sleep 3
mongo fonoster create-mongodb-user.js

# Bootstrap the service for developers
if [ "$FONOSTER_ENV" = "dev" ]
then
    ./bootstrap.sh $bootstrap
fi

# Stop mongo. Allow for a complete shutdown. Then start in secure mode.
mongo --eval "db.getSiblingDB('admin').shutdownServer()"; sleep 5
mongod --auth --config /etc/mongod.conf

echo 'Data server is up!'

while sleep 3600; do :; done