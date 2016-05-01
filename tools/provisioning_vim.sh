#!/bin/bash

DEIN_INSTALL_DIR="$HOME/.vim"

echo -e "\033[32mInstall dein.vim\033[m"
echo "--> $ curl -fsSL https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | bash -s $DEIN_INSTALL_DIR"
curl -fsSL https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | bash -s $DEIN_INSTALL_DIR
