#!/usr/bin/env bash

set -e

REV=$(cat .manifest)

echo "Pushing revision: $REV"

ANYARG="NONE"

if [ "$#" -eq 0 ]; then
  echo "We will install the entire system. For specific container use ./install.sh [container_name]"
else
  ANYARG="SOME"
fi

if [ "$ANYARG" = "SOME" ]; then
    for img in "$@"
    do
        gcloud docker -- push gcr.io/fonoster-app/$img:latest
        gcloud docker -- push gcr.io/fonoster-app/$img:$REV
    done
else
    gcloud docker -- push gcr.io/fonoster-app/dbsys:latest
    gcloud docker -- push gcr.io/fonoster-app/webapp:latest
    gcloud docker -- push gcr.io/fonoster-app/mediaserver:latest
    gcloud docker -- push gcr.io/fonoster-app/mediacontroller:latest

    gcloud docker -- push gcr.io/fonoster-app/dbsys:$REV
    gcloud docker -- push gcr.io/fonoster-app/webapp:$REV
    gcloud docker -- push gcr.io/fonoster-app/mediaserver:$REV
    gcloud docker -- push gcr.io/fonoster-app/mediacontroller:$REV
fi

