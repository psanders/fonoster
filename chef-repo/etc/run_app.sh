#!/bin/bash

# Starts astived
/opt/astive/bin/astived start &

# Starts Sip I/O
cd /opt/sipio/ && ./sipio &

# Starts the web server
service jetty start
service jetty start

# WARNING: Port have been hardcoded
echo $(python -c 'import socket; print(socket.gethostbyname(socket.gethostname()))') > index.html | python -m SimpleHTTPServer 8001

# Do I still need this?
sleep infinity