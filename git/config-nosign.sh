#!/bin/bash
# set git global configs

set -x 

git config --global core.editor "vim"
git config --global core.pager "less -r"
git config --global gpg.program gpg
git config --global commit.gpgsign false
