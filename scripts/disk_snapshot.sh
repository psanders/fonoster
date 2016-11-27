#!/usr/bin/env bash

. `dirname "$0"`/setup.cfg

DISK=$1
SNAPSHOT_NAME=$DISK$2

# Create snapshot of disk $DISK
gcloud compute disks snapshot $DISK --snapshot-names $SNAPSHOT_NAME --zone $ZONE
