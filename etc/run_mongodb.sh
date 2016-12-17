#!/usr/bin/env bash

repo=/var/chef-repo
db=fonoster

# Starts in secure mode and creates admin user for remote access
# Loading initial db entities including user john@doe.com
mongod --config /etc/mongod.conf --fork --logpath /var/log/mongodb.log
sleep 3
mongo $db $repo/etc/dbUser.js

if [ "$FONOSTER_ENV" = "dev" ]
then
    ./$repo/etc/init_db.sh $repo/data_bags/init_db
fi

# Starts mongod in secure mode
mongo --eval "db.getSiblingDB('admin').shutdownServer()"
# Allow mongo to completely shutdown. WARN: A better criteria is needed
sleep 3
mongod --auth --config /etc/mongod.conf --fork --logpath /var/log/mongodb.log

echo 'Data server is up!'

sleep infinity