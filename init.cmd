cd %HOMEPATH%
fsutil hardlink create _vimrc foundation\vim\vimrc
mkdir .vim\bundle
git clone https://github.com/Shougo/neobundle.vim .vim\bundle\neobundle.vim