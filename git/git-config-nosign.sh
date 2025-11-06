#!/bin/bash
# set git global configs

read -p 'Enter git username: ' user
read -p 'Enter git email: ' email

set -xe

git config --local user.name "$user"
git config --local user.email "$email"
git config --local core.fileMode false
git config --global core.editor "vim"
git config --global core.pager "less -r"
git config --global gpg.program gpg
git config --global commit.gpgsign false
git config --global core.autocrlf input
git config --global credential.helper store
