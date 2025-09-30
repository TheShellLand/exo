#!/bin/bash 

# glazewm config

cd "$(dirname "$0")"; set -xe 

HOME='/cygdrive/c/Users/Eric'

if [ -d "$HOME" ]; then 
  cp -rv .glzr "$HOME/"
fi

