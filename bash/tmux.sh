#!/bin/bash 

cd "$(dirname "$0")"

set +x 

mkdir -p ~/.config/tmux/plugins/catppuccin || :
git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux || :

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || :

cp -v .tmux.conf ~/

tmux source ~/.tmux.conf

echo done.

