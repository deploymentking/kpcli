#!/usr/bin/env bash

if [ -z "$KEEPASSX_PASSWORD" ]; then
  echo "No password specified"
  exit 1;
fi

if [ -z "$KEEPASSX_ENTRY" ]; then
  echo "No entry specified"
  exit 1;
fi

type kpcli >/dev/null 2>&1 || { echo >&2 "kpcli required but it's not installed.  Aborting."; exit 1; }

echo $KEEPASSX_PASSWORD > /bin/keepassx.pwd

kpcli --kdb /bin/keepassx.kdbx --pwfile /bin/keepassx.pwd --readonly --command "show -f $KEEPASSX_ENTRY" | grep Pass | sed 's/\ Pass\:\ //g' > /bin/keepassx.out

cat /bin/keepassx.out

if [ "$DOCKER_SPEC_KEEPALIVE" = 'true' ]; then tail -f /dev/null; fi
