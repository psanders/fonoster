#!/usr/bin/env sh

docs="User Account Activity Broadcast Rate ServiceProvider Gateway DIDNumber Domain Agent Peer"
db=fonoster
path=$1

if [ $# -eq 0 ]
then
    echo "Usage: $0 path/to/docs"
    exit 1
fi

for doc in $docs
do
	mongoimport --db $db --collection $doc --drop --file $path/$doc.json \
	    -u fonoster -p 308a002ab539471394a06ce710bc96c2
done