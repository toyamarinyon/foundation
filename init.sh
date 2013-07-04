#!/bin/bash

# create symbolic link from repository
# --------------------------------------
SCRIPT_PATH=$(cd $(dirname $0);pwd)
ln -s $SCRIPT_PATH/zsh/zprofile $HOME/.zprofile
ln -s $SCRIPT_PATH/zsh/zshrc $HOME/.zshrc
ln -s $SCRIPT_PATH/vim/vimrc $HOME/.vimrc
ln -s $SCRIPT_PATH/tmux/tmux.conf $HOME/.tmux.conf

# install neobundle.vim
# --------------------------------------
VIM_ROOT="$HOME/.vim"
NEOBUNDLE_DIR="$VIM_ROOT/bundle/neobundle.vim"

if [ -d $NEOBUNDLE_DIR ]; then
	echo "=> Neobundle is already installed in $NEOBUNDLE_DIR, trying to update"
	cd $NEOBUNDLE_DIR && git pull
else
	echo "=> Install Neobundle to $NEOBUNDLE_DIR"
	mkdir -p $NEOBUNDLE_DIR
	git clone git://github.com/Shougo/neobundle.vim $NEOBUNDLE_DIR
fi


# Detect profile file, .zprofile has precedance over .profile 
PROFILE=
if [ -f "$HOME/.zprofile" ]; then
	PROFILE=$HOME/.zprofile
elif [ -f "$HOME/.bash_profile" ]; then
	PROFILE=$HOME/.bash_profile
fi

SOURCE_STR="export VIM_ROOT=$VIM_ROOT"

if ! grep -qc 'export VIM_ROOT' $PROFILE; then
  echo "=> Appending source string to $PROFILE"
  echo "" >> "$PROFILE"
  echo $SOURCE_STR >> "$PROFILE"
else
  echo "=> Source string already in $PROFILE"
fi

echo "=> Close and reopen your terminal to start using vim"
