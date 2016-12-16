#!/bin/bash

# Start astived
/opt/astive/bin/astived start &

# Start apps
service jetty start
service jetty start

sleep infinity