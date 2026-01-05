typeset -U path PATH
addpath() { [[ -d "$1" ]] && path=("$1" $path) }
addpath "$GOPATH/bin"
addpath "$HOME/bin"
addpath "$HOME/.local/bin"
export PATH
