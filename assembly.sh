#!/usr/bin/env bash

set -e

VERSION=1.0.$(date +"%Y%m%d%H%M")

echo "Revision is: $VERSION"

cp app/voice/build/libs/voice-fat.jar      ops/docker/binaries
cp app/webui/build/libs/webui.war          ops/docker/binaries
cp app/webui/src/main/resources/web.xml    ops/docker/binaries
cp app/webui/src/main/resources/webui.xml  ops/docker/binaries
cp app/rest/src/main/resources/rest.xml    ops/docker/binaries
cp app/rest/build/libs/rest.war            ops/docker/binaries

mkdir -p ops/docker/binaries/static/assets/

cp -a app/resources/src/main/resources/META-INF/resources/assets/* ops/docker/binaries/static/assets

cd ops

ANYARG="NONE"

if [ "$#" -eq 0 ]; then
  echo "We will build the entire system. For specific container use ./assembly.sh [container_name]"
else
  ANYARG="SOME"
fi

if [ "$ANYARG" = "SOME" ]; then
    for img in "$@"
    do
        docker-compose build $img
        docker tag gcr.io/fonoster-app/$img:latest gcr.io/fonoster-app/$img:$VERSION
    done
else
    docker-compose build
    docker tag gcr.io/fonoster-app/dbsys:latest gcr.io/fonoster-app/dbsys:$VERSION
    docker tag gcr.io/fonoster-app/webapp:latest gcr.io/fonoster-app/webapp:$VERSION
    docker tag gcr.io/fonoster-app/mediaserver:latest gcr.io/fonoster-app/mediaserver:$VERSION
    docker tag gcr.io/fonoster-app/mediacontroller:latest gcr.io/fonoster-app/mediacontroller:$VERSION
fi

cd ..
echo $VERSION > .manifest