alias c='cd $(ghq list -p | peco)'
alias s='ssh $(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config|peco|awk "{print \$2}")'
alias m='mosh $(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config|peco|awk "{print \$2}")'
alias rm='rm -i'


case ${OSTYPE} in
  darwin*)
    alias chrome="open /Applications/Google\ Chrome.app"
    ;;
  linux*)
    ;;
esac
