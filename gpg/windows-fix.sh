#!/bin/bash 

# this fixes git commits when using gpg 

# you need to run this, I don't know if you can just source the file

export GPG_TTY=$(tty); $@

