
ulimit -n 65536
ulimit -u 2048

setopt interactive_comments
setopt hist_ignore_all_dups

alias -g G='| ag'
alias -g H='| head'
alias -g T='| tail'
alias gs='gsps'
alias gss='gs --stat'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
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

