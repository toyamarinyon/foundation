# {{{ Basic
set --export LANG en_US.UTF-8
set --export TERM xterm-256color
set --export EDITOR vim

test -f $HOME/.config/fish/private_environments.fish; and source $HOME/.config/fish/private_environments.fish
# }}}

# {{{ Bootstrap Development Tools

# homebrew
set --export PATH /usr/local/sbin /usr/local/bin $HOME/.rbenv/bin $PATH

# rbenv
which rbenv > /dev/null ^&1; and status --is-interactive; and source (rbenv init -|psub)

# nvm
test -s $HOME/.nvm-fish/nvm.fish; and source $HOME/.nvm-fish/nvm.fish

# }}}

