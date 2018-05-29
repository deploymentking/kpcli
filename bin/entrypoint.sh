#!/usr/bin/env bash

# Check pre-requisites
if [ -z "$FILENAME" ]; then echo >&2 "No filename specified"; exit 1; fi
if [ -z "$PASSWORD" ]; then echo >&2 "No password specified"; exit 1; fi
if [ -z "$ENTRY" ]; then echo >&2 "No entry specified"; exit 1; fi
type kpcli >/dev/null 2>&1 || { echo >&2 "kpcli required but it's not installed.  Aborting."; exit 1; }

# Get password from KeePassX file
echo $PASSWORD > ./keepassx.pwd
kpcli --kdb ./$FILENAME --pwfile ./keepassx.pwd --readonly --command "show -f $ENTRY" | grep Pass | sed 's/\ Pass\:\ //g'

# Tidy up
rm -rf ./keepassx.out ./keepassx.pwd
if [ "$DOCKER_SPEC_KEEPALIVE" = 'true' ]; then tail -f /dev/null; fi
