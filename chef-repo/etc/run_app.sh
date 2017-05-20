#!/bin/bash

# Starts astived
/opt/astive/bin/astived start &

# Starts Sip I/O
cd /opt/sipio/ && ./sipio &

# Starts the web server
service jetty start
service jetty start

sleep infinity