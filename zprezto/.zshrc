#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# http://wada811.blogspot.com/2014/09/zsh-cdr.html

# cdr, add-zsh-hook を有効にする
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
 
# cdr の設定
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

#

# コマンドラインでも # 以降をコメント扱いにする
setopt interactive_comments

# コマンド履歴で重複を無くす
setopt hist_ignore_all_dups

# コマンド履歴を他のターミナルと共有する
setopt share_history

# リダイレクトの保護機能をOFFにする
unsetopt noclobber

alias -g G='| ag'
alias -g H='| head'
alias -g T='| tail'
alias -g C='| pbcopy'
alias -g P='pbpaste |'
alias taketemp='cd $(mktemp -d)'
alias md='mkdir -p'

# 指定秒数以上コマンド実行に時間がかかったらtimeの結果を表示する
REPORTTIME=3

# 各種plugin

source ${ZDOTDIR:-$HOME}/dotfiles/oh-my-zsh/plugins/git/git.plugin.zsh
source ${ZDOTDIR:-$HOME}/dotfiles/oh-my-zsh/plugins/tmux/tmux.plugin.zsh
source ${ZDOTDIR:-$HOME}/dotfiles/oh-my-zsh-custom/cool-peco.zsh
source ${ZDOTDIR:-$HOME}/dotfiles/oh-my-zsh-custom/update-prompt-time.zsh
source ${ZDOTDIR:-$HOME}/dotfiles/oh-my-zsh-custom/homebrew.zsh

eval "$(rbenv init -)"

export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"
export GOPATH=$HOME/.go

