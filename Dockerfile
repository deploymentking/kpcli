FROM debian:stable-slim

LABEL Author="Lee Myring <mail@thinkstack.io>"
LABEL Maintainer="Lee Myring"
LABEL Description="kpcli wrapper instance"
LABEL Version="0.1"

RUN apt-get update \
    && apt-get install -y --no-install-recommends kpcli \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./bin /bin

RUN chmod 755 /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
