#!/usr/bin/env bash

. `dirname "$0"`/setup.cfg

gcloud docker -- pull $1
