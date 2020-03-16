# 以下が入っていること前提
# brew install xz
# brew install gnu-sed
# brew install homebrew/dupes/grep
# brew install binutils
# brew install coreutils
# brew install findutils

export PATH=$(brew --prefix gnu-sed)/libexec/gnubin:$PATH
export MANPATH=$(brew --prefix gnu-sed)/libexec/gnuman:$MANPATH
export PATH=$(brew --prefix grep)/bin:$PATH
export MANPATH=$(brew --prefix grep)/share/man:$MANPATH
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export MANPATH=$(brew --prefix coreutils)/libexec/gnuman:$MANPATH
export PATH=$(brew --prefix findutils)/libexec/gnubin:$PATH
export MANPATH=$(brew --prefix findutils)/libexec/gnuman:$MANPATH
alias strings=gstrings
alias grep=ggrep
if [ ! -e $(brew --prefix grep)/share/man/man1/grep.1 ]; then ln -s $(brew --prefix grep)/share/man/man1/{ggrep.1,grep.1}; fi

