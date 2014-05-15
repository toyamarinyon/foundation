# {{{ Basic
set --export LANG en_US.UTF-8
set --export TERM xterm-256color
set --export EDITOR vim
# }}}

# {{{ Bootstrap Development Tools

# homebrew
set --export PATH /usr/local/sbin /usr/local/bin $PATH

# rbenv
which rbenv 2> /dev/null; and status --is-interactive; and source (rbenv init -|psub)

# nvm
test -s $HOME/.nvm-fish/nvm.fish; and source $HOME/.nvm-fish/nvm.fish

# }}}

