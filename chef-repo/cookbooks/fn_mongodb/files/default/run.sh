#!/usr/bin/env bash

repo=/var/chef-repo

# Unrestricted while creating user
mongod --config /etc/mongod.conf; sleep 3
mongo fonoster  /app-user.js
mongo admin     /admin-user.js

# Bootstrap the service for developers
if [ "$FONOSTER_ENV" = "dev" ]
then
    ./bootstrap.sh $repo/data_bags/bootstrap
fi

# Stop mongo. Allow for a complete shutdown. Then start in secure mode.
mongo --eval "db.getSiblingDB('admin').shutdownServer()"; sleep 5
mongod --auth --config /etc/mongod.conf

echo 'Data server is up!'

sleep infinity