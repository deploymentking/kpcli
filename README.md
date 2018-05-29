# kpcli

[![Travis Build Status](https://travis-ci.org/deploymentking/kpcli.svg?branch=master)](https://travis-ci.org/deploymentking/kpcli)
[![Coverage Status](https://coveralls.io/repos/github/deploymentking/kpcli/badge.svg?branch=master)](https://coveralls.io/github/deploymentking/kpcli?branch=master)
[![Docker Build Status](https://dockerbuildbadges.quelltext.eu/status.svg?organization=thinkstackio&repository=kpcli&text=docker)](https://dockerbuildbadges.quelltext.eu/status.svg?organization=thinkstackio&repository=kpcli&text=docker)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

Debian-based Docker image that runs a very simple shell script to simply execute readonly requests to the bundled kpcli
package in order to extract password information from a KeePassX file. The file in question is determined by the
environment variables passed to the Docker image.

## Table of Contents

- [Script Usage](#script-usage)
  * [Example](#example)

## Script Usage

In order to extract passwords from a KeePassX file you will need four parameters:
- KPCLI_HOST_MOUNT: The local folder containing the KeePassX file that will be mounted to the Docker container's volume
- KPCLI_FILENAME: The name (and extension) of the KeePassX file 
- KPCLI_PASSWORD: The KeePassX file's password
- KPCLI_ENTRY: The path inside the KeePassX database of the desired entry from which to extract the password

### Example
```bash
# If your path has spaces don't forget to add double quotes around the string
KPCLI_HOST_MOUNT=/Users/$(whoami)/Downloads
KPCLI_FILENAME=NameOfKeePassXFile.kdbx
KPCLI_PASSWORD=supersecretpassword
KPCLI_ENTRY=/Root/Secret/Entry

docker run --net=none --rm -v ${KPCLI_HOST_MOUNT}:/keepassx -e FILENAME=${KPCLI_FILENAME} -e PASSWORD=${KPCLI_PASSWORD} -e ENTRY=${KPCLI_ENTRY} thinkstackio/kpcli:latest
```
