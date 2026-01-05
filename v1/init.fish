set -l SCRIPT_PATH (dirname (status -f))

echo
echo
echo     1.Make symbolic link for fish config file
echo
echo         $SCRIPT_PATH/fish '------------->' $HOME/.config/fish
echo
if test ! -s $HOME/.config/fish
  ln -s $SCRIPT_PATH/fish $HOME/.config/fish
  echo (set_color blue)
  echo           `---- Success!
else
  echo (set_color green) 
  echo           `---- $HOME/.config/fish is already exists.
end
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo $SCRIPT_PATH/fish '------------->' $HOME/.config/fish
if test ! -s $HOME/.config/fish
  ln -s $SCRIPT_PATH/fish $HOME/.config/fish
  echo (set_color blue) `---- Success!
else
  echo (set_color green) `---- $HOME/.config/fish is already exists.
end
echo (set_color white)
echo

echo
echo
echo Make symbolic link for .vimrc
echo
if test ! -s $HOME/.vimrc
  ln -s $SCRIPT_PATH/vim/vimrc $HOME/.vimrc
end

if test ! -s $HOME/.tmux.conf
  ln -s $SCRIPT_PATH/tmux/tmux.conf $HOME/.tmux.conf
end

if test ! -s $HOME/.gitconfig
  ln -s $SCRIPT_PATH/git/gitconfig $HOME/.gitconfig
end
