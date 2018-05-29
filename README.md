# kpcli

[![Travis Build Status](https://travis-ci.org/deploymentking/kpcli.svg?branch=master)](https://travis-ci.org/deploymentking/kpcli)
[![Coverage Status](https://coveralls.io/repos/github/deploymentking/kpcli/badge.svg?branch=master)](https://coveralls.io/github/deploymentking/kpcli?branch=master)
[![Docker Build Status](https://dockerbuildbadges.quelltext.eu/status.svg?organization=thinkstackio&repository=kpcli&text=docker)](https://dockerbuildbadges.quelltext.eu/status.svg?organization=thinkstackio&repository=kpcli&text=docker)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

Alpine docker image to run readonly requests to kpcli in order to extract password information from a KeePassX file.

## Table of Contents

<!-- toc -->

- [Script Usage](#script-usage)
  * [Example](#example)

<!-- tocstop -->

## Script Usage

In order to extract passwords from a KeePassX file you will need three parameters:
- Path to the KeePassX file 
- The KeePassX file's password
- The desired entry from which to extract the password

### Example
```bash
# If your path has spaces don't forget to add double quotes around the string
KEEPASSX_PATH=/path/to/keepassx.kdbx
KEEPASSX_ENTRY=/Root/Secret/Entry
KEEPASSX_PASSWORD=supersecretpassword

docker run --net=none --rm -v ${KEEPASSX_PATH}:/bin/keepassx.kdbx -e PASSWORD=${KEEPASSX_PASSWORD} -e ENTRY=${KEEPASSX_ENTRY} thinkstackio/kpcli
```


