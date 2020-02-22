#!/bin/bash
# set git global configs

set -x 

read -p "Enter git username: " user
read -p "Enter git email: " email

git config --global user.name "$user"
git config --global user.email "$email"
git config --global core.editor "vim"
git config --global core.pager "less -r"
git config --global gpg.program gpg
git config --global commit.gpgsign false
