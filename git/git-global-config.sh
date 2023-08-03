#!/bin/bash
# set git global configs

read -p "Enter git username: " user
read -p "Enter git email: " email

set -xe

git config --global user.name "$user"
git config --global user.email "$email"
git config --global user.signingkey "$email"
git config --global core.fileMode false
git config --global core.editor "vim"
git config --global core.pager "less -r"
git config --global gpg.program gpg
git config --global commit.gpgsign true
