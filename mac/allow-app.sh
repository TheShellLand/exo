#!/bin/bash

# allow a program to be run

set -xe

# "chromedriver” can’t be opened because Apple cannot check it for malicious software
xattr -d com.apple.quarantine "$@"
