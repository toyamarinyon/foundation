# {{{ Basic
set --export LANG en_US.UTF-8
set --export TERM xterm-256color
set --export EDITOR vim
# }}}

# {{{ Bootstrap Development Tools

# homebrew
set --export PATH /usr/local/sbin /usr/local/bin $PATH

# rbenv
if test -f $HOME/.rbenv/bin/rbenv
  set -export PATH $HOME/.rbenv/bin $PATH
  status --is-interactive; and . (rbenv init -|psub)
end

# nvm
test -s $HOME/.nvm-fish/nvm.fish; and source $HOME/.nvm-fish/nvm.fish

# }}}

