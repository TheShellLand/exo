#!/bin/bash

# take ownership of brew

# this happens when you log in as another user on MacOS

set -xe

sudo chown -R $(whoami) /usr/local/Homebrew
sudo chown -R $(whoami) /usr/local/share/aclocal /usr/local/share/locale /usr/local/share/man/man3 /usr/local/share/man/man7 /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/locks
chmod u+w /usr/local/Homebrew /usr/local/share/aclocal /usr/local/share/locale /usr/local/share/man/man3 /usr/local/share/man/man7 /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/locks
