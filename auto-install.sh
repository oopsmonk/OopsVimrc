#!/usr/bin/env bash

VIMHOME=~/.vim
VIMRC=~/.vimrc
MYVIM=~/OopsVimrc

[ -e "$VIMHOME/vimrc" ] && echo "VIMHOME/vimrc exists." && exit 1
[ -e "$VIMHOME" ] && echo "$VIMHOME exists." && exit 1

[ ! -d $MYVIM ] && git clone https://github.com/oopsmonk/OopsVimrc.git "$MYVIM"

ln -s "$MYVIM/vimrc" "$VIMRC"
ln -s "$MYVIM" "$VIMHOME"

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
