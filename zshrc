#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

plugins=(git zsh-syntax-highlighting)

# PATH stuff here...
#

# Git Aliases
alias gb='git branch'
alias gc='git checkout'
alias gf='git fetch --all --prune'
alias gr='git rebase'
alias gs='git status'
alias gl='git log'
alias gfiles='git show --pretty="" --name-only'
alias ggrep='git grep' $1
alias gdiff='git diff HEAD~ HEAD'
alias gdiffstat='git diff --stat HEAD~'
alias gdel='git branch -D'

# Tmux Aliases
alias tmuxa='tmux attach'
alias tmuxls='tmux list-sessions'
alias tmuxks='tmux kill-session -t'

# General Aliases
alias findfile='find . -name '
alias clearshots='rm -rf ~/Desktop/Screen\ *'


# Commands to run on startup
set -o emacs
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Terminal Colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

function cdg {
  cd "$(git rev-parse --show-toplevel)/${1}"
}
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig:/usr/local/opt/zlib/lib/pkgconfig:$PKG_CONFIG_PATH"
