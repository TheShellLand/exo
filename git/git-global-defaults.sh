#!/bin/bash
# set git global configs

set -xe

git config --global core.fileMode false
git config --global core.editor "vim"
git config --global core.pager "less -r"
git config --global gpg.program gpg
git config --global commit.gpgsign true
