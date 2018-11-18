#!/usr/bin/env bash

set -e

usage() {
	echo "Ensure docker and gcloud tools are installed and properly configure"
	echo "prior to using this script."
	echo ""
	echo "'make build' will build the docker images"
	echo "'make install' will push the images to the registry"
	echo "'make clean' will bring everything back to the originate state"
}

build() {
	VERSION=1.0.$(date +"%Y%m%d%H%M")
	echo "Revision is: $VERSION"

	ANYARG="NONE"

	if [ "$#" -eq 0 ]; then
	  echo "To build specific container use: ./make build [container_name]"
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
}

install() {
	REV=$(cat .manifest)

	echo "Pushing revision: $REV"

	ANYARG="NONE"

	if [ "$#" -eq 0 ]; then
	  echo "To install specific container use: ./make install [container_name]"
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
}

clean() {
	echo "Cleanning..."
	rm -rf app
	rm -f .manifest
	rm -rf docker/binaries
	echo "All done"
}

case "$1" in
        build)
            build $2
            ;;

        install)
            install $2
            ;;

				clean)
            clean
            ;;

        *)
            usage
            exit 1
esac
