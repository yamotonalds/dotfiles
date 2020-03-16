
ulimit -n 65536
ulimit -u 2048

setopt interactive_comments
setopt hist_ignore_all_dups

alias -g G='| ag'
alias -g H='| head'
alias -g T='| tail'
#alias gs='gsps'
alias gs='git show --pretty=medium --show-signature'
alias gss='gs --stat'
alias gcbcp='current_branch | pbcopy'
alias taketemp='cd "$(mktemp -d)"'
alias asum='awk "{sum=sum+\$1}END{print sum}"'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
    alias -g P='pbpaste |'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

# cdr 有効化
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

bindkey "^T" kill-word

# Git 2.9のdiff用
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

# 時間がかかったコマンドでtime結果自動表示
export REPORTTIME=3

# ansibleのcowsay無効化
export ANSIBLE_NOCOWS=1

if [ ${TMUX} ]; then
  unset zle_bracketed_paste
fi

eval "$(rbenv init -)"

