
source `dirname $0`/../cool-peco/cool-peco

# pecoでcdrを開く
function peco-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^@' peco-cdr

function peco-snippets() {
  if [ -f "`pwd`/.snippets" ]; then
    BUFFER=$(grep -v '^#' `pwd`/.snippets ~/.snippets | sort | peco --query "$LBUFFER" | cut -d':' -f 2)
  else
    BUFFER=$(grep -v '^#' ~/.snippets | peco --query "$LBUFFER")
  fi
  CURSOR=$#BUFFER
  zle clear-screen
}

zle -N peco-snippets
bindkey '^x^s' peco-snippets

zle -N cool-peco-history
bindkey '^r' cool-peco-history
zle -N cool-peco-filename-search
bindkey '^s' cool-peco-filename-search
zle -N cool-peco-git-log
bindkey '^l' cool-peco-git-log
zle -N cool-peco-git-checkout
bindkey '^o' cool-peco-git-checkout


git config --global alias.ag '!git ls-files | xargs ag --pager="less -R" --nogroup --color-match=0\;31 --color-path=0\;0 --no-numbers'


