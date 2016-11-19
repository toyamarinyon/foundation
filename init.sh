#!/bin/bash

# create symbolic link from repository
SCRIPT_PATH=`pwd`
rm -f $HOME/.zprofile
rm -f $HOME/.zshrc
rm -f $HOME/.vimrc
rm -f $HOME/.tmux.conf
rm -f $HOME/.gitconfig
rm -f $HOME/.zcustom.d
ln -s $SCRIPT_PATH/zsh/zprofile $HOME/.zprofile
ln -s $SCRIPT_PATH/zsh/zshrc $HOME/.zshrc
ln -s $SCRIPT_PATH/vim/vimrc $HOME/.vimrc
ln -s $SCRIPT_PATH/tmux/tmux.conf $HOME/.tmux.conf
ln -s $SCRIPT_PATH/git/gitconfig $HOME/.gitconfig
ln -s $SCRIPT_PATH/zsh/zcustom.d $HOME/.zcustom.d

# Detect profile file, .zprofile has precedance over .profile 
# PROFILE=
# if [ -f "$HOME/.zprofile" ]; then
# 	PROFILE=$HOME/.zprofile
# elif [ -f "$HOME/.bash_profile" ]; then
# 	PROFILE=$HOME/.bash_profile
# fi
# 
# VIM_ROOT_STR="export VIM_ROOT=$VIM_ROOT"
# 
# if ! grep -qc 'export VIM_ROOT' $PROFILE; then
#   echo "=> Appending VIM_ROOT to $PROFILE"
#   echo "" >> "$PROFILE"
#   echo $VIM_ROOT_STR >> "$PROFILE"
# else
#   echo "=> VIM_ROOT string already in $PROFILE"
# fi
# 
# echo "=> Close and reopen your terminal to start using vim"
