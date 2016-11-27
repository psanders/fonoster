#!/usr/bin/env bash

. `dirname "$0"`/setup.cfg

# Push the image
gcloud docker push $1
