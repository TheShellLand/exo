#!/bin/bash
# set git global configs

read -p "Enter git username: " user
read -p "Enter git email: " email

set -xe

git config --local user.name "$user"
git config --local user.email "$email"
git config --local user.signingkey "$email"
git config --global core.editor "vim"
git config --global core.pager "less -r"
git config --global gpg.program gpg
git config --global commit.gpgsign true
