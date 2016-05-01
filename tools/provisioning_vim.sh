#!/bin/sh

HERE=$(cd $(dirname $0) && pwd)
VIM_ROOT_DIR="$HOME/.vim"
DEIN_INSTALL_DIR="$VIM_ROOT_DIR/bundle"

echo -e "\033[32mInstall dein.vim\033[m"
echo "--> $ curl -fsSL https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh -s $DEIN_INSTALL_DIR"
curl -fsSL https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh -s $DEIN_INSTALL_DIR

echo ""

echo -e "\033[32mCreate symbolic link plugins.toml\033[m"
echo "---> $ ln -sf plugins.toml $VIM_ROOT_DIR/plugins.toml"
ln -sf $HERE/../vim/plugins.toml $VIM_ROOT_DIR/plugins.toml
