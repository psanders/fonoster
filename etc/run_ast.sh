#!/usr/bin/env bash

# Doing "service asterisk start" does not work due to an unknown reason.
asterisk -U asterisk -G asterisk
sleep infinity