#!/bin/sh

VIMHOME=~/.vim
VIMRC=~/.vimrc
MYVIM=~/OopsVimrc

[ -e "$VIMHOME/vimrc" ] && echo "VIMHOME/vimrc exists." && exit 1
[ -e "$VIMHOME" ] && echo "$VIMHOME exists." && exit 1

[ ! -d $MYVIM ] && git clone https://github.com/oopsmonk/OopsVimrc.git "$MYVIM"

ln -s "$MYVIM/vimrc" "$VIMRC"
ln -s "$MYVIM" "$VIMHOME"

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

vim +NeoBundleInstall +qall
